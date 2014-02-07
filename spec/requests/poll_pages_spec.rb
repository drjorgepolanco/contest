require 'spec_helper'

describe "poll pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "poll creation" do
    before { visit new_poll_path }

    describe "with invalid information" do

      it "should not create a poll" do
        expect { click_button "Done" }.not_to change(Poll, :count)
      end

      describe "error messages" do
        before { click_button "Done" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do


      before { fill_in 'poll_title', with: "Lorem ipsum" }

      before do 
        fill_in 'poll_description',  with: "Lorem ipsum dolor sit amet makagrano"
        fill_in 'poll_image',        with: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-ash4/p480x480/1003930_10152044972593961_1549075083_n.jpg"
        end


      it "should create a poll" do
        expect { click_button "Done" }.to change(Poll, :count).by(1)
      end
    end
  end

  describe "poll index" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:p1) { FactoryGirl.create(:poll, user: user, title: "Foo Bar", image: "http://media-cache-ak0.pinimg.com/736x/01/ba/3f/01ba3f4711dae0acd4ad746064b57c55.jpg") }
    let!(:p2) { FactoryGirl.create(:poll, user: user, title: "Bar Foo", image: "http://media-cache-ak0.pinimg.com/736x/4c/61/72/4c6172baf4da23c6b6d8f284a48ae16f.jpg") }

    before { visit polls_path }

    it { should have_content('polls') }
    it { should have_title('polls') }

    describe "polls" do
      it { should have_content(p1.title) }
      it { should have_content(p2.title) }
      it { should have_content(user.polls.count) }
    end
  end

  describe "poll destruction" do
    before { FactoryGirl.create(:poll, user: user) }

    describe "as correct user" do
      before { visit polls_path }

      # it "should delete a poll" do
      #   expect { click_link '<i class="fi-trash"></i>' }.to change(poll, :count).by(-1)
      # end
    end
  end

end
