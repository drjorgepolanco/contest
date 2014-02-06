require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('Users') }
    it { should have_content('Users') }

    describe "delete links" do

      it { should_not have_link('delete') }

      # describe "as an admin user" do
      #   let(:admin) { FactoryGirl.create(:admin) }
      #   before do
      #     sign_in admin
      #     visit users_path
      #   end

      #   it { should have_link('<i class="fi-trash"></i>', href: user_path(User.first)) }
        
      #   it "should be able to delete another user" do
      #     expect do
      #       click_link('<i class="fi-trash"></i>', match: :first)
      #     end.to change(User, :count).by(-1)
      #   end
      #   it { should_not have_link('<i class="fi-trash"></i>', href: user_path(admin)) }
      # end
    end
  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_title(full_title ('Followed Users')) }
      it { should have_selector('h4', text: 'Followed Users') }
      it { should have_link(other_user.first_name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_title(full_title ("Followers")) }
      it { should have_selector('h4', text: 'Followers') }
      it { should have_link(user.first_name, href: user_path(user)) }
    end
  end



  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit user_path(user)
    end

    it { should have_content(user.profile_pic) }

    describe "posts" do
      it { should have_content(user.posts.count) }
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:post, user: user, title: "Lorem Ipsum", description: "Color sit amet makagrano", image: "https://scontent-a-dfw.xx.fbcdn.net/hphotos-prn1/1531956_10151888749228946_1983280094_n.jpg")
        FactoryGirl.create(:post, user: user, title: "Ipsum Lorem", description: "Makagrano amet sit color", image: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-prn2/1549485_10151888740363946_1938070629_n.jpg")
        sign_in user
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("div##{item.id}", text: item.title)
        end
      end
    
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
        end

        it { should have_link("0", href: following_user_path(user)) }
        it { should have_link("0", href: followers_user_path(user)) }
      end
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "clicking the button" do
          before { click_button "Follow" }
          it { should have_xpath("//input[@value='Unfollow']") }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the user's followed count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "clicking the button" do
          before { click_button "Unfollow" }
          it { should have_xpath("//input[@value='Follow']") }
        end
      end
    end
  end


  # describe "for signed-in users" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   before do
  #     FactoryGirl.create(:post, user: user, title: "Lorem Ipsum", description: "Color sit amet makagrano", image: "https://scontent-a-dfw.xx.fbcdn.net/hphotos-prn1/1531956_10151888749228946_1983280094_n.jpg")
  #     FactoryGirl.create(:post, user: user, title: "Ipsum Lorem", description: "Makagrano amet sit color", image: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-prn2/1549485_10151888740363946_1938070629_n.jpg")
  #     sign_in user
  #     visit user_path
  #   end

  #   describe "the user's feed" do
  #     let(:user) { FactoryGirl.create(:user) }
  #     before do
  #       FactoryGirl.create(:post, user: user, title: "Lorem Ipsum", description: "Color sit amet makagrano", image: "https://scontent-a-dfw.xx.fbcdn.net/hphotos-prn1/1531956_10151888749228946_1983280094_n.jpg")
  #       FactoryGirl.create(:post, user: user, title: "Ipsum Lorem", description: "Makagrano amet sit color", image: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-prn2/1549485_10151888740363946_1938070629_n.jpg")
  #     end

  #     user.feed.each do |item|
  #       expect(page).to have_selector("li##{item.id}", text: item.content)
  #     end
  #   end

    
  # end
  # end

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
        fill_in "First name",                   with: "Jorge"
        fill_in "Last name",                    with: "Polanco"
        fill_in "Tag",                          with: "Web Developer"         
        fill_in "Email",                        with: "dr.jorgepolanco@gmail.com"
        fill_in "Password",                     with: "foobar"
        fill_in "Password confirmation",        with: "foobar"
      end

      it "should create a user" do 
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'dr.jorgepolanco@gmail.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.first_name) }
        it { should have_selector('div.alert.alert-success', text: "Welcome") }
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
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_first_name) { "Juan" }
      let(:new_last_name) { "Perez" }
      let(:new_tag) { "Web Developer" }
      let(:new_email) { "info@talentcrops.com" }
      before do
        fill_in "First name",         with: new_first_name
        fill_in "Last name",          with: new_last_name
        fill_in "Tag",                with: new_tag
        fill_in "Email",              with: new_email
        fill_in "Password",           with: user.password
        fill_in "Confirm Password",   with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_first_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.first_name).to eq new_first_name }
      specify { expect(user.reload.last_name).to eq new_last_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
