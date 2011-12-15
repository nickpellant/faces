require File.dirname(__FILE__) + '/../test_helper'

class GravatarTest < Test::Unit::TestCase
 
  ####################
  #--- url        ---#
  ####################
  def test_url_should_return_non_secure_gravatar_url
    obj = ::Faces::Providers::Gravatar.new
    url = obj.url('da9658571a8ca10cf8b0f91625a8c3d5')
    assert_match 'http://gravatar.com/avatar', url
  end
  
  def test_url_should_return_secure_gravatar_url
    obj = ::Faces::Providers::Gravatar.new
    url = obj.url('da9658571a8ca10cf8b0f91625a8c3d5', {:use_secure => true})
    assert_match 'https://secure.gravatar.com/avatar', url
  end
  
  ####################
  #--- html       ---#
  ####################
  def test_html_should_return_non_secure_gravatar_image_html
    obj = ::Faces::Providers::Gravatar.new
    html = obj.html('da9658571a8ca10cf8b0f91625a8c3d5')
    assert_match '<img src="http://gravatar.com/', html
  end
  
  def test_html_should_return_secure_gravatar_image_html
    obj = ::Faces::Providers::Gravatar.new
    html = obj.html('da9658571a8ca10cf8b0f91625a8c3d5', {:use_secure => true})
    assert_match '<img src="https://secure.gravatar.com/', html
  end
  
  def test_html_should_work_with_string_emails
    obj = ::Faces::Providers::Gravatar.new
    html = obj.html('someone@something.com')
    assert_match '<img src="http://gravatar.com/', html
  end
  
  ####################
  #--- exists?    ---#
  ####################
  def test_exists_should_return_false_if_avatar_doesnt_exist
    obj = ::Faces::Providers::Gravatar.new
    result = obj.exists?('someone@example.com')
    assert_equal false, result, 'Avatar does not exist, should have returned false'
  end
  
  def test_exists_should_return_true_if_avatar_exists
    obj = ::Faces::Providers::Gravatar.new
    result = obj.exists?('da9658571a8ca10cf8b0f91625a8c3d5')
    assert_equal true, result, 'Avatar exists, should have returned true'
  end
  
  def test_exists_should_return_false_if_avatar_doesnt_exist_on_secure
    obj = ::Faces::Providers::Gravatar.new
    result = obj.exists?('someone@example.com', {:use_secure => true})
    assert_equal false, result, 'Avatar does not exist, should have returned false'
  end
  
  def test_exists_should_return_true_if_avatar_does_exist_on_secure
    obj = ::Faces::Providers::Gravatar.new
    result = obj.exists?('da9658571a8ca10cf8b0f91625a8c3d5', {:use_secure => true})
    assert_equal true, result, 'Avatar does exist, should have returned true'
  end
  ####################
  #--- md5_email  ---#
  ####################
  def test_md5_email_should_return_correct_md5_hash
    obj = ::Faces::Providers::Gravatar.new
    result = obj.md5_email(' soMEonE@exaMPle.com  ')
    assert_equal Digest::MD5.hexdigest('someone@example.com'), result, 'MD5 has does not match correctly'
  end
  
  ####################
  #--- hostname   ---#
  ####################
  def test_hostname_should_return_non_secure_hostname
    obj = ::Faces::Providers::Gravatar.new
    assert_match 'http://gravatar.com', obj.__send__(:hostname, {:use_secure => false})
  end
  
  def test_hostname_should_return_secure_hostname
    obj = ::Faces::Providers::Gravatar.new
    assert_match 'https://secure.gravatar.com', obj.__send__(:hostname, {:use_secure => true})
  end
end