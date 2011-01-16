# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

record = User.new :email=>"admin@example.com",   :login=>'admin',    :password=>"admin12345",     :password_confirmation => "admin12345",    :role => 'admin',     :name => "The Administrator"
record.ensure_authentication_token
record.save!(:validate => false)

record = User.new :email=>"api@example.com",     :login=>'api',      :password=>"api12345",       :password_confirmation => "api12345",      :role => 'api',       :name => "The API User"
record.ensure_authentication_token
record.save!(:validate => false)

record = User.new :email=>"normal@example.com",  :login=>'normal',   :password=>"normal12345",    :password_confirmation => "normal12345",   :role => 'normal',    :name => "The Normal"
record.ensure_authentication_token
record.save!(:validate => false)

record = User.new :email=>"normal1@example.com", :login=>'normal1',   :password=>"normal12345",    :password_confirmation => "normal12345",   :role => 'normal',    :name => "The Normal1"
record.ensure_authentication_token
record.save!(:validate => false)

record = User.new :email=>"disabled@example.com",:login=>'disabled', :password=>"disabled12345",  :password_confirmation => "disabled12345", :role => 'normal',  :name => "The Disabled"
record.ensure_authentication_token
record.lock_access!

