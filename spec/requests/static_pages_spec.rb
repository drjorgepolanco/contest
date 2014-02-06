require 'spec_helper'

describe "Static Pages" do

  subject {page}

  shared_examples_for "all static pages" do
    it {should have_selector('h4', text: heading)}
    it {should have_title(full_title(page_title))}
  end

  describe "Home page" do
    before {visit root_path}
    let(:heading)     {'Talentcrops'}
    let(:page_title)  {''}

    it { should_not have_title('| Home')}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:post, user: user, title: "Lambda Phi Kappa", image: "http://www.skepticalscience.com/pics/environmental-ad.jpg")
        FactoryGirl.create(:post, user: user, title: "Lambda Phi Kappa", image: "https://scontent-b-dfw.xx.fbcdn.net/hphotos-ash4/p480x480/1003930_10152044972593961_1549075083_n.jpg")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("div##{item.id}", text: item.title)
        end
      end
    end
  end

  describe "Help page" do
    before {visit help_path}
    let(:heading)     {'Help'}
    let(:page_title)  {''}

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before {visit about_path}
    let(:heading)     {'About Us'}
    let(:page_title)  {''}

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before {visit contact_path}
    let(:heading)     {'Contact Us'}
    let(:page_title)  {''}

    it_should_behave_like "all static pages"     
  end
end