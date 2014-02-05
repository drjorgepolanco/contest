require 'spec_helper'

describe "challenges/new" do
  before(:each) do
    assign(:challenge, stub_model(Challenge,
      :user => nil,
      :title => "MyString",
      :description => "MyText",
      :views => 1,
      :tag => "MyString",
      :image => "MyString"
    ).as_new_record)
  end

  it "renders new challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", challenges_path, "post" do
      assert_select "input#challenge_user[name=?]", "challenge[user]"
      assert_select "input#challenge_title[name=?]", "challenge[title]"
      assert_select "textarea#challenge_description[name=?]", "challenge[description]"
      assert_select "input#challenge_views[name=?]", "challenge[views]"
      assert_select "input#challenge_tag[name=?]", "challenge[tag]"
      assert_select "input#challenge_image[name=?]", "challenge[image]"
    end
  end
end
