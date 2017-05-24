require 'httparty'
require 'json'

class Kele
  include HTTParty

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: { "email": email, "password": password })
    raise response.code if response.code != 200
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end

# mark mentor_id = 2290632
  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token }).to_a
    available = []
    response.each do |timeslot|
      if timeslot["booked"] == nil
        available.push(timeslot)
      end
    end
    puts available
  end

  # def get_mentor_availability(mentor_id)
  #   response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", values: { id: mentor_id }, headers: { authorization: @auth_token })
  #   @mentor_avail = JSON.parse(response.body)
  # end

end