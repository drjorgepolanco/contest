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
                      profile_pic: "http://media-cache-ec0.pinimg.com/736x/43/f1/73/43f173f56c91bb56702a90bf5bfb02f0.jpg",
                      tag: "Web Developer",
                      password: "foobar", 
                      password_confirmation: "foobar",
                      admin: true)

  99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    profile_pic = "https://scontent-a-dfw.xx.fbcdn.net/hphotos-ash3/t1/529434_784879471539780_740672644_n.jpg"
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
    title = Faker::Lorem.sentence(1)
    description = Faker::Lorem.sentence(4)
    image = "https://scontent-a-dfw.xx.fbcdn.net/hphotos-frc3/1531643_10153663979055317_222641967_n.jpg"
    users.each { |user| user.posts.create!(title: title,
                                          description: description,
                                          image: image) }
  end
end

def make_challenges
  users = User.all(limit: 10)
  15.times do 
    title = Faker::Lorem.sentence(1)
    description = Faker::Lorem.sentence(4)
    image = "http://media-cache-ec0.pinimg.com/736x/0d/61/82/0d618222ed9070af615bf29b54243205.jpg"
    users.each { |user| user.challenges.create!(title: title,
                                          description: description,
                                          image: image) }
  end
end

def make_polls
  users = User.all(limit: 10)
  15.times do 
    title = Faker::Lorem.sentence(1)
    description = Faker::Lorem.sentence(4)
    image = "http://media-cache-ec0.pinimg.com/736x/9a/b8/23/9ab8233cddc0d085f6db2a6ff52961ed.jpg"
    users.each { |user| user.challenges.create!(title: title,
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