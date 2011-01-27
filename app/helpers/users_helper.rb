module UsersHelper
  USER_API_DEFAULT_ATTRIBUTES = %w(id login role email name locked_at).map(&:to_sym).freeze
  
  
  def user_json(user=@user, &block)
    as_user_json(user,&block).to_json
  end
    
  def as_user_json(user=@user, &block)
    json = user.as_json(:only => USER_API_DEFAULT_ATTRIBUTES)
    json.merge!('url' => user_path(user)) unless user.new_record?
    yield json if block_given?
    json
  end
  
  def user_xml(user=@user, options={}, &block)
    chain_proc = Proc.new do |xml| 
      xml.url user_path(user, :format => :xml) unless user.new_record?
      block.call(xml) if block
    end
    user.to_xml(
      options.merge(:only => USER_API_DEFAULT_ATTRIBUTES, :skip_types => true),
      &chain_proc)
  end
  
  def lock_xml(xml, user = @user)
    xml.lock do
      xml.user user_path(@user, :format => :xml)
      ActiveSupport::XmlMini.to_tag :locked_at, 
          @user.locked_at, 
          :skip_types => true,
          :builder => xml
    end
  end
  
  def lock_json(user=@user)
    as_lock_json(user).to_json
  end
  
  def as_lock_json(user = @user)
    {
      :user => user_path(@user),
      :locked_at => @user.locked_at
    }.as_json
  end
end
