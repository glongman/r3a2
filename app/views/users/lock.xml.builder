xml.lock do
  xml.user user_url(@user)
  ActiveSupport::XmlMini.to_tag :locked_at, @user.locked_at, :builder => xml
end