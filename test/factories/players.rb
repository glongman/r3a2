# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :player do |f|
  f.sequence(:name)       {|n| "player#{n}".titleize}
  f.sequence(:email)      {|n| "player#{n}@example.com" }
end
