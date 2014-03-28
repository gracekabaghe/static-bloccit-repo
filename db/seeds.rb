require 'faker'

User.destroy_all
Post.destroy_all
Topic.destroy_all
Comment.destroy_all

topics = []
15.times do
  topics << Topic.create(
    name: Faker::Lorem.words(rand(1..10)).join(" "), 
    description: Faker::Lorem.paragraph(rand(1..4))
  )
end 

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  u.skip_confirmation!
  u.save

  # Note: by calling `User.new` instead of `create`,
  # we create an instance of a user which isn't saved to the database.
  # The `skip_confirmation!` method sets the confirmation date
  # to avoid sending an email. The `save` method updates the database.

  rand(5..12).times do
    topic = topics.first #getting the first topic here
    p = u.posts.create(
      topic: topic,
      title: Faker::Lorem.words(rand(1..10)).join(" "), 
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    # set the created_at to a time within the past year
    p.update_attribute(:created_at, Time.now - rand(600..31536000))
    topics.rotate!
    # commets ....
   
    rand(3..7).times do
      p.comments.create(

        body: Faker::Lorem.paragraphs(rand(1..2)).join("\n")
      )
    end
  end
end
   
User.all.each do |user|
  rand(30..50).times do
    p = Post.all.sample(1).first
    c = user.comments.create(
      body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"),
      post: p)
    c.update_attribute(:created_at, Time.now - rand(600..31536000))
  end
end

  
  u = User.new(
  name: 'Admin User',
  email: 'admin@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'moderator')

u = User.new(
  name: 'Member User',
  email: 'member@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

u = User.new(
  name: 'Grace',
  email: 'gracema2002@gmail.com',
  password: 'password',
  password_confirmation: 'password'
  )
u.skip_confirmation!
u.save


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"

puts "#{Comment.count} comments created"   

