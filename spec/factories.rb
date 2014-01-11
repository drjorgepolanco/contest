FactoryGirl.define do
  factory :user do
    first_name            "Jorge"
    last_name             "Polanco"
    email                 "dr.jorgepolanco@gmail.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end