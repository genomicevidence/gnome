u = User.new
u.assign_attributes({:email => "admin@example.com", :password => "admin", :confirmed_at => DateTime.now}, :as => :admin)
u.save!(:validate => false)