require 'faker'
require 'set'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    make_microposts
    make_connections
  end
end

def make_users
  # User.create!(name:"muffintin0",
  #              email:"hmchem@gmail.com",
  #              password:"chasehu0",
  #              password_confirmation:"chasehu0")
  40.times do |n|
    first_name=Faker::Name.first_name
    last_name=Faker::Name.last_name
    puts "#{first_name} #{last_name}"
    email="#{first_name}-#{last_name}@fakermail.com"
    password="password"
    User.create!(username:"#{first_name} #{last_name}",email:email,password:password,password_confirmation:password)
  end
end

def make_microposts
  users=User.all
  users.each do |user|
    20.times do
      content=Faker::Lorem.sentences(2).join(' ')
      while content.length > 140
        content=Faker::Lorem.sentences(2).join(' ')
      end
      user.microposts.create!(body:content)
    end
    user.microposts[0..5].each do |micropost|
      original_post_id=rand(500) #generate repost
      while original_post_id == micropost.id
        original_post_id=rand(500)
      end
      micropost.original_post_id=original_post_id
      micropost.save
    end
  end
end

def make_connections
  users=User.all
  users.each do |user|
    followings=random_followings(30,users.length,user.id)
    followings.each do |following_id|
      user.connections.create!(following_id:following_id)
    end
  end
end

def random_followings(max_size,max_number,follower_id)
  followings=Set.new
  while followings.size<max_size do
    following_id=1+rand(max_number)
    followings << following_id unless following_id==follower_id 
  end
  followings
end
