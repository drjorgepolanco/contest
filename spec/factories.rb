FactoryGirl.define do
  factory :user do
    sequence(:first_name)  { |n| "Person #{n}" }
    sequence(:last_name)  { |n| "#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    tag "Web Developer"
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :post do
    title "Amazing Post"
    description "Lorem ipsum color sit amet"
    image "http://lh5.ggpht.com/-1j0TvHflT08/UbeqfPd2srI/AAAAAAAAAi4/Mb70XFYNWgc/s9000/Anti_grumpy_cat-resizecrop--.jpg"
    tag "funny"
    user
  end

  factory :challenge do
    title "Amazing Challenge"
    description "Lorem ipsum color sit amet"
    image "http://lh5.ggpht.com/-1j0TvHflT08/UbeqfPd2srI/AAAAAAAAAi4/Mb70XFYNWgc/s9000/Anti_grumpy_cat-resizecrop--.jpg"
    tag "funny"
    user
  end

  factory :poll do
    title "Incredible Poll"
    description "Agua chi fau chu jacha color sit amet"
    image "http://media-cache-ak0.pinimg.com/736x/45/9b/2d/459b2d1ab446e418ff95bad54bc43d15.jpg"
    tag "animals"
    user
  end
end