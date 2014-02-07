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

  describe "challenge index" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:c1) { FactoryGirl.create(:challenge, user: user, title: "Foo Bar", image: "http://media-cache-ak0.pinimg.com/736x/01/ba/3f/01ba3f4711dae0acd4ad746064b57c55.jpg") }
    let!(:c2) { FactoryGirl.create(:challenge, user: user, title: "Bar Foo", image: "http://media-cache-ak0.pinimg.com/736x/4c/61/72/4c6172baf4da23c6b6d8f284a48ae16f.jpg") }

    before { visit challenges_path }

    it { should have_content('Challenges') }
    it { should have_title('Challenges') }

    describe "challenges" do
      it { should have_content(c1.title) }
      it { should have_content(c2.title) }
      it { should have_content(user.challenges.count) }
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
