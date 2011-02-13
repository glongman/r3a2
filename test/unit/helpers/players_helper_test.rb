require 'test_helper'
require 'builder'
require 'json'
require 'app/helpers/application_helper'
class PlayersHelperTest < ActionView::TestCase
  include ApplicationHelper
  def setup
    @player = Factory :player
  end
    
  def test_player_json_has_url
    hash = as_player_json
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@player), hash['url']
  end
  
  def test_new_player_has_no_url
    hash = as_player_json Factory.build :normal_user
    assert !hash.has_key?('url'), 'expected no url but got one'
  end
  
  def test_player_json_with_block_still_has_url
    hash = as_player_json do |json|
      json.merge!(:foo => :moo)
    end
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@player), hash['url']
    assert hash.has_key?(:foo), "expected :foo but didn't get it"
    assert_equal :moo, hash[:foo]
  end
    
  def test_player_xml_has_url
    xml = model_xml
    hash = Hash.from_xml(xml)['user']
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@player, :format => :xml), hash['url']
  end
  
  def test_new_player_xml_has_no_url
    xml = model_xml Factory.build :normal_user
    hash = Hash.from_xml(xml)['user']
    assert !hash.has_key?('url'), 'expected no url but got one'
  end
  
  def test_player_xml_with_block_still_has_url
    xml = model_xml do |xml|
      xml.foo "moo"
    end
    hash = Hash.from_xml(xml)['user']
    assert hash.has_key?('url'), "expected url but didn't get it"
    assert_equal user_path(@player, :format => :xml), hash['url']
    assert hash.has_key?('foo'), "expected :foo but didn't get it"
    assert_equal 'moo', hash['foo']
  end
  
  def test_lock_json
    @player.lock_access!
    time = @player.locked_at
    hash = as_player_lock_json
    assert_equal({'locked_at' => time.as_json, 'user' => user_path(@player)}, hash)
  end
  
  def test_lock_xml
    @player.lock_access!
    time = @player.locked_at
    xml = player_lock_xml Builder::XmlMarkup.new
    hash = Hash.from_xml(xml)['lock']
    assert_equal({'locked_at' => time.as_json, 'user' => user_path(@player, :format => :xml)}, hash)
  end
  
  protected
  
  def as_player_json(player=@player)
    JSON::parse model_json(player)
  end
  
end

