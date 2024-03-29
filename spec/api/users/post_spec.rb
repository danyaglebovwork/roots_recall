require "rails_helper"

RSpec.describe "POST api/users" do
  subject { post "/api/users", headers: default_headers, params: payload.to_json }

  let!(:payload) do
    {
      user: {
        first_name: "first_name",
        last_name: "last_name",
        father_name: "father_name",
        email: "fake@email.com",
        password: "password",
        confirmation_password: "password"
      }
    }
  end

  it "responds with 200" do
    subject

    expect(response.status).to eq(200)

    expect(response.json[:id]).to be_present
    expect(response.json[:first_name]).to eq("first_name")
    expect(response.json[:last_name]).to eq("last_name")
    expect(response.json[:father_name]).to eq("father_name")
    expect(response.json[:email]).to eq("fake@email.com")
  end
end
