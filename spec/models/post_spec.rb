require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }
  before { @post = user.posts.build(title: "Amazing Post", description: "Lorem ipsum color sit amet", 
                                    image: "http://lh5.ggpht.com/-1j0TvHflT08/UbeqfPd2srI/AAAAAAAAAi4/Mb70XFYNWgc/s9000/Anti_grumpy_cat-resizecrop--.jpg") }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @post.title = " " }
    it { should_not be_valid }
  end

  describe "with too long title" do
    before { @post.title = "a" * 71 }
    it { should_not be_valid }
  end

  describe "with blank image" do
    before { @post.image = " " }
    it { should_not be_valid }
  end
end

