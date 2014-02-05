require 'spec_helper'

describe "challenges/edit" do
  before(:each) do
    @challenge = assign(:challenge, stub_model(Challenge,
      :user => nil,
      :title => "MyString",
      :description => "MyText",
      :views => 1,
      :tag => "MyString",
      :image => "MyString"
    ))
  end

  it "renders the edit challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", challenge_path(@challenge), "post" do
      assert_select "input#challenge_user[name=?]", "challenge[user]"
      assert_select "input#challenge_title[name=?]", "challenge[title]"
      assert_select "textarea#challenge_description[name=?]", "challenge[description]"
      assert_select "input#challenge_views[name=?]", "challenge[views]"
      assert_select "input#challenge_tag[name=?]", "challenge[tag]"
      assert_select "input#challenge_image[name=?]", "challenge[image]"
    end
  end
end
