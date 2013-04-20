namespace :db do
  desc "Inject the guest account"
  task guest: :environment do
    make_guest
    #make_microposts
    #make_connections
  end
end

def make_guest
	old_guest=User.find_by_username('anonymous')
	if old_guest
		old_guest.destroy
	end
	guest=User.create!(username:"anonymous",email:'guest@example.com',password:'password',password_confirmation:'password')
	guest.confirmed_at=Time.new
	guest.save

	users=User.all
	users.each do |user|
		guest.connections.create(following_id:user.id) unless user==guest
	end
	User.find_by_username('muffintin0').connections.create(following_id:guest.id)
	User.find_by_username('xiaoming').connections.create(following_id:guest.id)
end