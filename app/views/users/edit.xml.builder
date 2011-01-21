@user.to_xml(:builder => xml) do |builder|
  builder.password ""
  builder.password_confirmation ""
  builder.url user_url(@user) unless @user.new_record?
end