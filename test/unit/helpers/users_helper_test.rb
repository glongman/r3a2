require 'test_helper'
require 'builder'
class UsersHelperTest < ActionView::TestCase
  def setup
    @user = Factory :admin_user
    @default_keys = UsersHelper::USER_API_DEFAULT_ATTRIBUTES.collect(&:to_s) << 'url'
  end
  
  def test_user_json_includes_default_keys
    hash = as_user_json
    assert_not_nil hash
    @default_keys.each do |k| 
      assert hash.has_key?(k), "expected key #{k.inspect} but didn't get it"
    end
  end
  
  def test_user_json_has_url
    hash = as_user_json
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@user), hash['url']
  end
  
  def test_new_user_has_no_url
    hash = as_user_json Factory.build :normal_user
    assert !hash.has_key?('url'), 'expected no url but got one'
  end
  
  def test_user_json_with_block_still_has_url
    hash = as_user_json do |json|
      json.merge!(:foo => :moo)
    end
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@user), hash['url']
    assert hash.has_key?(:foo), "expected :foo but didn't get it"
    assert_equal :moo, hash[:foo]
  end
  
  def test_user_xml_includes_default_keys
    xml = user_xml
    assert !xml.blank?
    hash = Hash.from_xml(xml)['user']
    @default_keys.each do |k| 
      assert hash.has_key?(k), "expected key #{k.inspect} but didn't get it"
    end
  end
  
  def test_user_xml_has_url
    xml = user_xml
    hash = Hash.from_xml(xml)['user']
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@user, :format => :xml), hash['url']
  end
  
  def test_new_user_xml_has_no_url
    xml = user_xml Factory.build :normal_user
    hash = Hash.from_xml(xml)['user']
    assert !hash.has_key?('url'), 'expected no url but got one'
  end
  
  def test_user_xml_with_block_still_has_url
    xml = user_xml do |xml|
      xml.foo "moo"
    end
    hash = Hash.from_xml(xml)['user']
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@user, :format => :xml), hash['url']
    assert hash.has_key?('foo'), "expected :foo but didn't get it"
    assert_equal 'moo', hash['foo']
  end
  
  def test_lock_json
    @user.lock_access!
    time = @user.locked_at
    hash = as_lock_json
    assert_equal({'locked_at' => time.as_json, 'user' => user_path(@user)}, hash)
  end
  
  def test_lock_xml
    @user.lock_access!
    time = @user.locked_at
    xml = lock_xml Builder::XmlMarkup.new
    hash = Hash.from_xml(xml)['lock']
    assert_equal({'locked_at' => time.as_json, 'user' => user_path(@user, :format => :xml)}, hash)
  end
  
end
