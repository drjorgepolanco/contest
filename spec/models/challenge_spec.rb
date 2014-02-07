require 'spec_helper'

describe Challenge do

  let(:user) { FactoryGirl.create(:user) }
  before { @challenge = user.challenges.build(title: "Lorem ipsum", description: "Color sit amet makagrano", 
                  image: "http://media-cache-ec0.pinimg.com/736x/8c/54/b8/8c54b8dd24b02391b4cd12a5584eb5c4.jpg", 
                  user_id: user.id) }

  subject { @challenge }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:image) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @challenge.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @challenge.title = " " }
    it { should_not be_valid }
  end

  describe "with blank image" do
    before { @challenge.image = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @challenge.title = "a" * 51 }
    it { should_not be_valid }
  end
end