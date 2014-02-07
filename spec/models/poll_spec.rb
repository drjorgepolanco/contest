require 'spec_helper'

describe Poll do

  let(:user) { FactoryGirl.create(:user) }
  before { @poll = user.polls.build(title: "Lorena Ipsuna", description: "This is just amazing, I love to code every second more", image: "http://media-cache-ak0.pinimg.com/736x/55/c8/73/55c87308f3734556bf9b8a0b0d8e76a7.jpg", user_id: user.id) }

  subject { @poll }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:image) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @poll.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @poll.title = " " }
    it { should_not be_valid }
  end

  describe "with title too long" do
    before { @poll.title = "x" * 51 }
    it { should_not be_valid }
  end
end
