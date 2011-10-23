#encoding: utf-8

require "spec_helper"

describe AuthController do
  context "POST welcome" do
    it "разбирает данные пользователя" do
      post :welcome, {
        "post_form_id" => "d2a7eecde6e22a387a17bb14d0899868",
        "fb_dtsg" => "AQCAoXIk",
        "signed_request" => "8EKkzUUJYy-J88VCwN2ZVA2-Oz5NRmDOKFdwXUj1fD0.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMTkzODkyMDAsImlzc3VlZF9hdCI6MTMxOTM4NTM2MSwib2F1dGhfdG9rZW4iOiJBQUFCMmdsRnFMWkNZQkFLVExiclBaQkxZUXZaQTE5WEFOcHlLQkFkOVpBU3FGeTdCNUpnYTgwZzNVVUFtaVQ1czVud2h1Uk8zaEU0VXZaQmlhNFQ4UHlkcGw5VTlrNXJoUEpaQ05wWGx0SVpDeVY4UDFzcHJjRFpBIiwidXNlciI6eyJjb3VudHJ5IjoicnUiLCJsb2NhbGUiOiJydV9SVSIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMDAwMDEyNTYxNDg3NTIifQ"
      }
      response.should be_ok
    end
  end
end
