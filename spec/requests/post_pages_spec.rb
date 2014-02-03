require 'spec_helper'

describe "Post pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "post creation" do
    before { visit new_post_path }

    describe "with invalid information" do

      it "should not create a post" do
        expect { click_button "Done" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Done" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do


      before { fill_in 'post_title', with: "Lorem ipsum" }

      before do 
        fill_in 'post_title',        with: "Lorem ipsum" 
        fill_in 'post_description',  with: "Lorem ipsum dolor sit amet makagrano"
        fill_in 'post_image',        with: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-ash4/p480x480/1003930_10152044972593961_1549075083_n.jpg"
        end


      it "should create a post" do
        expect { click_button "Done" }.to change(Post, :count).by(1)
      end
    end
  end

  describe "post destruction" do
    before { FactoryGirl.create(:post, user: user) }

    describe "as correct user" do
      before { visit posts_path }

      # it "should delete a post" do
      #   expect { click_link '<i class="fi-trash"></i>' }.to change(Post, :count).by(-1)
      # end
    end
  end

end