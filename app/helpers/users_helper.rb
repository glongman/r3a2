module UsersHelper
  
  def lock_xml(xml, user = @user)
    xml.lock do
      xml.user user_url(@user)
      ActiveSupport::XmlMini.to_tag :locked_at, 
          @user.locked_at, 
          :skip_types => true,
          :builder => xml
    end
  end
  
  def lock_json(user = @user)
    {
      :user => user_path(@user),
      :locked_at => @user.locked_at
    }.to_json
  end
end
