namespace :assign do
  desc "TODO"
  task :valet_to_order => :environment do
  	user = User.find_by_email("gh.abhradip@gmail.com")
  	user.update_attributes(:is_admin => true)
  	p "Admin role has been assigned to the user successfully."
  end
end