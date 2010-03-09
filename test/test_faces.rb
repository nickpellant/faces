require File.dirname(__FILE__) + '/test_helper'

class FacesTest < Test::Unit::TestCase
  def setup
  end
  
  ####################
  #--- avatar_url ---#
  ####################
  def test_avatar_url_should_return_avatar_url_non_secure
    url = Faces::Public.avatar_url('someone@something.com', 'gravatar')
    assert_match 'http', url
  end
  
  def test_avatar_url_should_return_avatar_url_secure
    url = Faces::Public.avatar_url('someone@something.com', 'gravatar', {:use_secure => true})
    assert_match 'https', url
  end
  
  def test_avatar_url_should_return_default_when_provider_doesnt_exist
    url = Faces::Public.avatar_url('someone@something.com', 'imnotreal')
    assert_equal url, Faces::Public.avatar_default_url
  end
  
  def test_avatar_url_should_return_default_when_provider_method_doesnt_exist
    url = Faces::Public.avatar_url('xyz', 'facebook')
    assert_equal url, Faces::Public.avatar_default_url
  end
  
  #####################
  #--- avatar_html ---#
  #####################
  def test_avatar_html_should_return_avatar_url_non_secure
    url = Faces::Public.avatar_html('someone@something.com', 'gravatar')
    assert_match 'http', url
  end
  
  def test_avatar_html_should_return_avatar_url_secure
    url = Faces::Public.avatar_html('someone@something.com', 'gravatar', {:use_secure => true})
    assert_match 'https', url
  end
  
  def test_avatar_html_should_return_default_when_provider_doesnt_exist
    url = Faces::Public.avatar_html('someone@something.com', 'imnotreal')
    assert_equal url, Faces::Public.avatar_default_html
  end
  
  ########################
  #--- avatar_exists? ---#
  ########################
  def test_avatar_exists_should_return_true_when_an_avatar_exists
    exists = Faces::Public.avatar_exists?('da9658571a8ca10cf8b0f91625a8c3d5', 'gravatar')
    assert_equal exists, true
  end
  
  def test_avatar_exists_should_return_false_when_an_avatar_doesnt_exists
    exists = Faces::Public.avatar_exists?('someone@something.com', 'gravatar')
    assert_equal exists, false
  end
end