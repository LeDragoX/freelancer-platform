require 'rails_helper'

describe "Visit home page" do
  context "without authentication" do
    it "successfully" do
      visit root_path
    end
  end

  context "as an user" do
    it "successfully" do
      user = User.create!({ email: "user@test.com", password: "123456" })
      
      visit root_path

      login_as user, scope: :user
    end
  end

  context "as a freelancer" do
    it "successfully" do
      freelancer = Freelancer.create!({ email: "freelancer@test.com", password: "123456" })

      visit root_path

      login_as freelancer, scope: :freelancer
    end
  end
end
