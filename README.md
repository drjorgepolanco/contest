# Photo Sharing Social Network

by [Jorge Polanco](http://drjorgepolanco.wordpress.com/).

### Features

* **Socialize!:** Users can follow and be followed by other users.
* **Share!:** Users can share Posts and create Contests.
* **Interact!:** Users can vote on the best posts and write comments.
* **Find Out!:** Live feed allows the user to know what's going on with the people he follows. Any user can see in another user's profile what the people this last user is following are doing.

### Technologies
* **Ruby on Rails, HTML5 & CSS3**
* **Deployment & Security:** Heroku & SSL
* **Data Storage:** Amazon S3
* **Image Upload:** Carrierwave
* **Testing:** RSPEC
* **Fully Responsive Web Design**

**Live Version, visit:**
  [talentcrop](http://talentcrop.herokuapp.com/)

**Localhost:** clone or fork the repo and then...

    bundle install
    bundle exec rake db:drop db:create db:migrate
    
**Populate the database with seed data:**

    bundle exec rake db:populate

**Run tests with rspec:**

    bundle exec rake test:prepare
    bundle exec rspec spec/



