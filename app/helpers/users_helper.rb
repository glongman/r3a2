module UsersHelper
  USER_API_DEFAULT_ATTRIBUTES = %w(id login role email name locked_at).map(&:to_sym).freeze
  
  
  def user_json(users=@user, &block)
    model_json(users, :only => USER_API_DEFAULT_ATTRIBUTES, &block)
  end
    
  # def as_user_json(user=@user, &block)
  #     json = user.as_json(:only => USER_API_DEFAULT_ATTRIBUTES)
  #     json.merge!('url' => user_path(user)) unless user.new_record?
  #     yield json if block_given?
  #     json
  #   end
  
  def user_xml(user=@user, options={}, &block)
    model_xml user, :only => USER_API_DEFAULT_ATTRIBUTES, &block
  end
  
  def user_lock_xml(xml, user = @user)
    xml.lock do
      xml.user user_path(@user, :format => :xml)
      ActiveSupport::XmlMini.to_tag :locked_at, 
          @user.locked_at, 
          :skip_types => true,
          :builder => xml
    end
  end
  
  def user_lock_json(user=@user)
    as_user_lock_json(user).to_json
  end
  
  def as_user_lock_json(user = @user)
    {
      :user => user_path(@user),
      :locked_at => @user.locked_at
    }.as_json
  end
end
