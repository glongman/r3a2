require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = Factory :user_with_auth_token
    @default_keys = User::API_DEFAULT_ATTRIBUTES.collect(&:to_s)
  end
  
  def test_default_json
    hash = @user.as_json
    assert_not_nil hash
    assert_has_default_keys hash, true
  end
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  protected
  def assert_has_default_keys(hash, only_default_keys)
    hash = hash.dup
    @default_keys.each do |k| 
      assert hash.has_key?(k), "expected key #{k.inspect} but didn't get it"
      hash.delete(k)
    end
    assert(hash.empty?, "expected only default keys but also got: #{hash.inspect}") if only_default_keys
    hash
  end
end
