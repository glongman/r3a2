# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.sequence(:email)      {|n| "user#{n}@example.com" }
  f.sequence(:login)      {|n| "user#{n}" }
  f.sequence(:name)       {|n| "user#{n}".titleize}
  f.password              {"password"}
  f.password_confirmation {"password"}
end

Factory.define :admin_user, :parent => :user do |f|
  f.role {"admin"}
end

Factory.define :api_user, :parent => :user do |f|
  f.role {"api"}
end

Factory.define :normal_user, :parent => :user do |f|
  f.role {"normal"}
end

Factory.define :disabled_user, :parent => :user do |f|
  f.role {"disabled"}
end

Factory.define :user_with_auth_token, :parent => :user do |f|
  f.after_create do |user_record|
    user_record.ensure_authentication_token!
  end
end
    
