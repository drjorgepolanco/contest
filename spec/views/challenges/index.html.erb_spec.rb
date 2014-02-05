require 'spec_helper'

describe "challenges/index" do
  before(:each) do
    assign(:challenges, [
      stub_model(Challenge,
        :user => nil,
        :title => "Title",
        :description => "MyText",
        :views => 1,
        :tag => "Tag",
        :image => "Image"
      ),
      stub_model(Challenge,
        :user => nil,
        :title => "Title",
        :description => "MyText",
        :views => 1,
        :tag => "Tag",
        :image => "Image"
      )
    ])
  end

  it "renders a list of challenges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
