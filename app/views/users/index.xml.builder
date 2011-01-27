xml.users do |xml|
  @users.each do |u|
    user_xml u, :builder => xml, :skip_instruct => true
  end
end