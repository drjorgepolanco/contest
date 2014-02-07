namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
    make_challenges
    # make_polls
  end
end

def make_users
  admin = User.create!(first_name: "Jorge", 
                      last_name: "Polanco", 
                      email: "dr.jorgepolanco@gmail.com", 
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
  50.times do 
    title = "Lorem Ipsum"
    description = "Color sit amet makagrano"
    image = "https://scontent-a-dfw.xx.fbcdn.net/hphotos-frc3/1531643_10153663979055317_222641967_n.jpg"
    users.each { |user| user.posts.create!(title: title,
                                          description: description,
                                          image: image) }
  end
end

def make_challenges
  users = User.all(limit: 10)
  50.times do 
    title = content = Faker::Lorem.sentence(1)
    description = Faker::Lorem.sentence(4)
    image = "http://media-cache-ak0.pinimg.com/736x/c6/7c/d0/c67cd06ae7c972aeb0a48ca59c95fe28.jpg"
    users.each { |user| user.challenges.create!(title: title,
                                          description: description,
                                          image: image) }
  end
end

# def make_polls
#   users = User.all(limit: 10)
#   50.times do 
#     title = content = Faker::Lorem.sentence(1)
#     description = Faker::Lorem.sentence(4)
#     image = "http://media-cache-ak0.pinimg.com/736x/17/b9/9f/17b99f98332ea486d58e36631c2952f9.jpg"
#     users.each { |user| user.challenges.create!(title: title,
#                                           description: description,
#                                           image: image) }
#   end
# end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end