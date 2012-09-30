class RequestsController < ApplicationController
  def show
    #respond_to do |format|
      #format.html
    #end
  end
  def schedule
    # get start and end window of first day
    request_start = params["day_start"][0].to_i
    request_end = params["day_end"][0].to_i

    # convert to bitmask string with 48 bits, where a 1 indicates availability
    client_request = "0" * 48
    (request_start * 2).to_i.upto((request_end * 2).to_i) { |i|
      client_request[i] = "1"
    }
    client_request = client_request.to_i(2)

    @vets = User.all.select { |user| %w(vet technician).include?(user.role) }

    vet =
      @vets.find do |vet|
        availability_start = 9
        availability_end = 17

        # convert to bitmask string with 48 bits, where a 1 indicates availability
        vet_availability = "0" * 48
        (availability_start * 2).upto(availability_end * 2) { |i| vet_availability[i] = "1" }
        vet_availability = vet_availability.to_i(2)

        start_hour = ("%48s" % (client_request & vet_availability).to_s(2)).index("111") / 2 # 1.5hr request
        vet
      end
   raise "No available vets" unless vet

   vet.requests.create(assigned_vet_id: vet.id, requested_slots_serialized: {day_starts: params["day_start"], day_ends: params["day_end"]}.to_json, round_count: 0, user_id: 1, visit_type: "a")
  end
end
