namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
    make_challenges
    make_polls
  end
end

def make_users
  admin = User.create!(first_name: "Jorge", 
                      last_name: "Polanco", 
                      email: "dr.jorgepolanco@gmail.com", 
                      profile_pic: "http://media-cache-ak0.pinimg.com/736x/02/eb/0b/02eb0b450e656e9a5b9f0ef6b9662459.jpg",
                      tag: "Web Developer",
                      password: "foobar", 
                      password_confirmation: "foobar",
                      admin: true)

  99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    profile_pic = "http://media-cache-cd0.pinimg.com/736x/e4/2d/85/e42d85fe74eb41cd59e42132eb017532.jpg"
    tag = "Lover"
    email = "example-#{n+1}@talentcrops.com"
    password = "password"
    User.create!(first_name: first_name,
                last_name: last_name,
                profile_pic: profile_pic,
                tag: tag,
                email: email,
                password: password,
                password_confirmation: password)
  end
end

def make_posts
  users = User.all(limit: 10)
  15.times do 
    title = "This is a Post"
    description = Faker::Lorem.sentence(4)
    image = "http://media-cache-ak0.pinimg.com/736x/fe/aa/47/feaa47b6d8446f13418dfc18abbada03.jpg"
    users.each { |user| user.posts.create!(title: title,
                                          description: description,
                                          image: image) }
  end
end

def make_challenges
  users = User.all(limit: 10)
  15.times do 
    title = "This is a Challenge"
    description = Faker::Lorem.sentence(4)
    image = "http://media-cache-ak0.pinimg.com/736x/f7/31/ae/f731ae3448a404710013aac3057cc51a.jpg"
    users.each { |user| user.challenges.create!(title: title,
                                          description: description,
                                          image: image) }
  end
end

def make_polls
  users = User.all(limit: 10)
  15.times do 
    title = "This is a Poll"
    description = Faker::Lorem.sentence(4)
    image = "http://media-cache-ec0.pinimg.com/736x/b8/f2/9c/b8f29c4fbfbf2e7ef849b5eaa3f5259f.jpg"
    users.each { |user| user.polls.create!(title: title,
                                          description: description,
                                          image: image) }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end