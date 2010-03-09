require File.dirname(__FILE__) + '/../test_helper'

class HighriseTest < Test::Unit::TestCase

  ####################
  #--- url        ---#
  ####################
  def test_url_should_return_non_secure_highrise_url
    obj = ::Faces::Providers::Highrise.new
    url = obj.url('31479012', {:highrise_account_name => 'silentaletest'})
    assert_match 'http://silentaletest.highrisehq.com/dl/avatars/person/3147/9012', url
  end
  
  def test_url_should_return_secure_highrise_url
    obj = ::Faces::Providers::Highrise.new
    url = obj.url('31479012', {:highrise_account_name => 'silentaletest', :use_secure => true})
    assert_match 'https://silentaletest.highrisehq.com/dl/avatars/person/3147/9012', url
  end
  
  ####################
  #--- html       ---#
  ####################
  def test_html_should_return_non_secure_highrise_image
    obj = ::Faces::Providers::Highrise.new
    html = obj.html('31479012', {:highrise_account_name => 'silentaletest'})
    assert_match '<img src="http://silentaletest.highrisehq.com/dl/avatars/person/3147/9012', html
  end
  
  def test_html_should_return_secure_highrise_image
    obj = ::Faces::Providers::Highrise.new
    html = obj.html('31479012', {:highrise_account_name => 'silentaletest', :use_secure => true})
    assert_match '<img src="https://silentaletest.highrisehq.com/dl/avatars/person/3147/9012', html
  end

  ####################
  #--- exists?    ---#
  ####################
  def test_exists_should_return_true_if_avatar_exists_non_secure
    obj = ::Faces::Providers::Highrise.new
    result = obj.exists?('31479012', {:highrise_account_name => 'silentaletest', :use_secure => true})
    assert_equal true, result, 'Avatar does exist, should have returned true'
  end

  def test_exists_should_return_true_if_avatar_exists_secure
    obj = ::Faces::Providers::Highrise.new
    result = obj.exists?('31479012', {:highrise_account_name => 'silentaletest', :use_secure => true})
    assert_equal true, result, 'Avatar does exist, should have returned true'
  end
  
  def test_exists_should_return_false_if_avatar_doesnt_exist_non_secure
    obj = ::Faces::Providers::Highrise.new
    result = obj.exists?('31706827', {:highrise_account_name => 'silentaletest', :use_secure => true})
    assert_equal false, result, 'Avatar doesn\'t exist, should have returned false'
  end

  def test_exists_should_return_false_if_avatar_doesnt_exist_secure
    obj = ::Faces::Providers::Highrise.new
    result = obj.exists?('31706827', {:highrise_account_name => 'silentaletest', :use_secure => true})
    assert_equal false, result, 'Avatar doesn\'t exist, should have returned false'
  end
  ####################
  #--- size       ---#
  ####################
  def test_size_should_return_small
    obj = ::Faces::Providers::Highrise.new
    assert_equal 'small', obj.__send__(:size, {:size => 32})
  end
  
  def test_size_should_return_large
    obj = ::Faces::Providers::Highrise.new
    assert_equal 'large', obj.__send__(:size, {:size => 54})
  end
end