class RequestsController < ApplicationController

  def show
    #respond_to do |format|
      #format.html
    #end
  end
 
  # This Schedules / Creates a request
  def schedule
    # get start and end window of first day
    day_starts = params["day_starts"].collect { |string_num| string_num.to_f }
    day_ends = params["day_ends"].collect { |string_num| string_num.to_f }

    request_start = day_starts[0].to_f
    request_end = day_ends[0].to_f

    # goes through vets to find vet who can take this request
    vet =
      User.providers.find do |vet|
        if find_start_time(vet, request_start, request_end, hours_for_visit(params["type"]))
          vet
        end
      end
    raise "No available vets" unless vet

    request = Request.new(
      assigned_vet_id: vet.id,
      requested_slots_serialized: {day_starts: day_starts, day_ends: day_ends}.to_json,
      round_count: 0,
      nos_serialized: [].to_json,
      visit_type: "a" # TODO
    )
    request.user = current_user
    raise "couldn't save user :(" unless request.save
  end

  def accept
    request_id = params[:request_id]
    req = Request.find( request_id )
    @start_hour = find_start_time(current_user, req.get_start_time, req.get_end_time)
    @type = req.visit_type
    visit = Visit.create( start_time: @start_hour, visit_type: @type, provider_id: current_user.id, client_id: req.user.id)
    req.destroy
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
    raise "no one wants this guy though" if vet.nil? # TODO: move over to next day!
    req.assigned_vet_id= vet.id
    req.save
  end

  private
  # This either returns a start_hour in 24hr format or nil (if the vet cannot take the request)
  def find_start_time(vet, request_start, request_end, hours_long) # vet, request_start, request_end ---> start_hr OR nil
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

    # slot length in bits, represented as string of binary ones (each bit
    # represents 30 mins in bitmask)
    visit_length_bit_string = "1" * (2 * hours_long)

    # return start hour by finding starting index of a run of 1's in the
    # bitmask which is as long as visit_length_bit_string
    index = ("%48s" % (client_request & vet_availability).to_s(2)).index(visit_length_bit_string)
    if index.nil?
      # no vets found :(
      nil
    else
      # the starting time! (divide by 2 because of 30 minute granularity)
      index / 2.0
    end
  end

  # takes a, b, or c and returns length in hours
  def hours_for_visit(type)
    {"a" => 1, "b" => 1.5, "c" => 2}[type]
  end

end
