require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Talentcrops" }

  describe "Home page" do

    # it "should render all posts" do
    #   visit root_path
    #   expect(page).to render_template(:partial => "_post")
    # end

    it "should not have title Home" do
      visit root_path
      expect(page).not_to have_title("Home")
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/help'
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit '/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/about'
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit '/about'
      expect(page).to have_title("#{base_title} | About Us")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit '/contact'
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      visit '/contact'
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end

# require 'spec_helper'

# describe "Static Pages" do

#   subject {page}

#   shared_examples_for "all static pages" do
#     it {should have_content('h4', text: heading)}
#     it {should have_title(full_title(page_title))}
#   end

#   describe "Home page" do
#     before {visit root_path}
#     let(:heading)     {'Talentcrops'}
#     let(:page_title)  {''}

#     it { should_not have_title('| Home')}

#     describe "for signed-in users" do
#       let(:user) { FactoryGirl.create(:user) }
#       before do
#         FactoryGirl.create(:post, user: user, title: "Lambda Phi Kappa", image: "http://www.skepticalscience.com/pics/environmental-ad.jpg")
#         FactoryGirl.create(:post, user: user, title: "Lambda Phi Kappa", image: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-ash4/p480x480/1003930_10152044972593961_1549075083_n.jpg")
#         sign_in user
#         visit root_path
#       end

#       it "should render the user's feed" do
#         user.feed.each do |item|
#           expect(page).to have_selector("div##{item.id}", text: item.title)
#         end
#       end
#     end
#   end

#   describe "Help page" do
#     before {visit help_path}
#     let(:heading)     {'Help'}
#     let(:page_title)  {''}

#     it_should_behave_like "all static pages"
#   end

#   describe "About page" do
#     before {visit about_path}
#     let(:heading)     {'About Us'}
#     let(:page_title)  {''}

#     it_should_behave_like "all static pages"
#   end

#   describe "Contact page" do
#     before {visit contact_path}
#     let(:heading)     {'Contact Us'}
#     let(:page_title)  {''}

#     it_should_behave_like "all static pages"     
#   end
# end

