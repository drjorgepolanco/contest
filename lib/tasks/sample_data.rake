namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(first_name: "Jorge", 
                last_name: "Polanco", 
                email: "dr.jorgepolanco@gmail.com", 
                password: "foobar", 
                password_confirmation: "foobar",
                admin: true)
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "example-#{n+1}@email.com"
      password = "password"
      User.create!(first_name: first_name,
                  last_name: last_name,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end
  end
end
