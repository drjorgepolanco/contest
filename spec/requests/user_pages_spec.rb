require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.first_name) }
    it { should have_content(user.last_name) }
    it { should have_title(user.first_name) }
  end

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create Account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",         with: "Jorge"
        fill_in "Last name",          with: "Polanco"
        fill_in "Email",              with: "dr.jorgepolanco@gmail.com"
        fill_in "Password",           with: "foobar"
        fill_in "Password confirmation",       with: "foobar"
      end

      it "should create a user" do 
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
