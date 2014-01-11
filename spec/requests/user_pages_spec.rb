require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, first_name: "Bob", last_name: "Bullock", email: 'bob@bullock.com')
      FactoryGirl.create(:user, first_name: "Marco", last_name: "Carola", email: 'marco@carola.com')
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.first_name)
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.first_name) }
    it { should have_content(user.last_name) }
    it { should have_title(user.first_name) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create Account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign Up') }
        it { should have_content('error') }
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

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'dr.jorgepolanco@gmail.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.first_name) }
        it { should have_selector('div.alert-box.alert-success', text: "Welcome") }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit profile") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_first_name) { "Juan" }
      let(:new_last_name) { "Perez" }
      let(:new_email) { "info@talentcrops.com" }
      before do
        fill_in "First name",         with: new_first_name
        fill_in "Last name",          with: new_last_name
        fill_in "Email",              with: new_email
        fill_in "Password",           with: user.password
        fill_in "Confirm Password",   with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_first_name) }
      it { should have_selector('div.alert-box.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.first_name).to eq new_first_name }
      specify { expect(user.reload.last_name).to eq new_last_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
