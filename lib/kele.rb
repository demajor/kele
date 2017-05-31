require 'httparty'
require 'json'
require 'kele/roadmap'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: { "email": email, "password": password })
    raise response.code if response.code != 200
    @auth_token = response["auth_token"]
  end

# my id = 25247
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

  def get_messages(page)
    response = self.class.get("https://www.bloc.io/api/v1/message_threads", body: { "page" => page }, headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, subject, stripped_text)
    response = self.class.post("https://www.bloc.io/api/v1/messages",
    { body: { sender: sender, recipient_id: recipient_id, subject: subject, "stripped-text" => stripped_text }, headers: { "authorization" => @auth_token }})
  end

  # def create_message(sender, recipient_id, subject, stripped_text)
  #   values_headers = { body: { sender: sender, recipient_id: recipient_id, subject: subject, "stripped-text" => stripped_text}, headers: { authorization: @auth_token } }
  #   response = self.class.post("https://www.bloc.io/api/v1/messages", values_headers)
  # end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", 
    { body: { enrollment_id: user_enrollment_id, checkpoint_id: checkpoint_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, comment: comment }, headers: { "authorization" => @auth_token }})
  end

  private

  def user_enrollment_id
    @user['current_enrollment']['id']
  end

end



