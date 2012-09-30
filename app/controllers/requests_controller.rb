class RequestsController < ApplicationController

  def new
    @request = Request.new
    #respond_to do |format|
      #format.html
    #end
  end
 
  # This Schedules / Creates a request
  def create
    # get start and end window of first day
    day_starts = params["day_starts"].collect { |string_num| string_num.to_f }
    day_ends = params["day_ends"].collect { |string_num| string_num.to_f }

    request_start = day_starts[0].to_f
    request_end = day_ends[0].to_f

    @vets = User.all.select { |user| user.is_provider? }

    vet = @vets.select{ |vet| find_start_time(vet, request_start, request_end) }.first

    if vet.present?
      appointment_request = vet.requests.create(
        user_id: current_user.id,
        requested_slots_serialized: {day_starts: day_starts, day_ends: day_ends}.to_json,
        round_count: 0,
        nos_serialized: [].to_json,
        visit_type: "a" # TODO
      )
    end

    redirect_to :root
  end

  def accept
    request_id = params[:request_id]
    req = Request.find( request_id )
    @start_hour = find_start_time(current_user, req.get_start_time, req.get_end_time)
    @type = req.visit_type
    visit = Visit.create( start_time: @start_hour, visit_type: @type, provider_id: current_user.id, client_id: req.client.id)
    req.destroy

    redirect_to :root
  end

  def decline
    req = Request.find params[:request_id]
    req.assigned_vet_id= nil #unassign the cur vet
    req.save
    req.nos+=[current_user.id]
    # goes through vets to find vet who can take this request
    vet = 
      User.providers.find do |vet|
        # check if vet is on blacklist
        if !req.nos.include?(vet.id)
          if find_start_time(vet, req.get_start_time, req.get_end_time)
            vet
          end
        end
      end

    if vet.present?
      req.assigned_vet_id= vet.id
      req.save
    else
      req.destroy
    end

    redirect_to :root
  end

  private
  # This either returns a start_hour in 24hr format or nil (if the vet cannot take the request)
  def find_start_time(vet, request_start, request_end) # vet, request_start, request_end ---> start_hr OR nil
    #check if vet is blacklisted
    
    # convert to bitmask string with 48 bits, where a 1 indicates availability
    client_request = "0" * 48
    (request_start * 2).to_i.upto(((request_end - 0.5) * 2).to_i) { |i|
      client_request[i] = "1"
    }
    client_request = client_request.to_i(2)

    availability_start = 9 #TODO: fix
    availability_end = 17

    # convert to bitmask string with 48 bits, where a 1 indicates availability
    vet_availability = "0" * 48 #TODO: subtract....
    (availability_start * 2).upto((availability_end - 0.5) * 2) { |i| vet_availability[i] = "1" }
    vet_availability = vet_availability.to_i(2)

    #start hour
    ("%48s" % (client_request & vet_availability).to_s(2)).index("111") / 2.0 # TODO: 1.5hr request
  end
end
