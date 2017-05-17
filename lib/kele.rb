require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: { "email": email, "password": password })
    raise response.code if response.code != 200
    @auth_token = response["auth_token"]
  end
end