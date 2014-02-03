namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
  end
end

def make_users
  admin = User.create!(first_name: "Jorge", 
                      last_name: "Polanco", 
                      email: "dr.jorgepolanco@gmail.com", 
                      password: "foobar", 
                      password_confirmation: "foobar",
                      admin: true)

  99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    profile_pic = "https://scontent-a-dfw.xx.fbcdn.net/hphotos-ash3/t1/529434_784879471539780_740672644_n.jpg"
    email = "example-#{n+1}@talentcrops.com"
    password = "password"
    User.create!(first_name: first_name,
                last_name: last_name,
                profile_pic: profile_pic,
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

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end