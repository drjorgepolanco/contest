require 'spec_helper'

describe "challenge pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "challenge creation" do
    before { visit new_challenge_path }

    describe "with invalid information" do

      it "should not create a challenge" do
        expect { click_button "Done" }.not_to change(Challenge, :count)
      end

      describe "error messages" do
        before { click_button "Done" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do


      before { fill_in 'challenge_title', with: "Lorem ipsum" }

      before do 
        fill_in 'challenge_description',  with: "Lorem ipsum dolor sit amet makagrano"
        fill_in 'challenge_image',        with: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-ash4/p480x480/1003930_10152044972593961_1549075083_n.jpg"
        end


      it "should create a challenge" do
        expect { click_button "Done" }.to change(Challenge, :count).by(1)
      end
    end
  end

  describe "challenge destruction" do
    before { FactoryGirl.create(:challenge, user: user) }

    describe "as correct user" do
      before { visit challenges_path }

      # it "should delete a challenge" do
      #   expect { click_link '<i class="fi-trash"></i>' }.to change(challenge, :count).by(-1)
      # end
    end
  end

end
