require File.dirname(__FILE__) + '/../test_helper'

class FlickrTest < Test::Unit::TestCase

  ####################
  #--- url        ---#
  ####################
  def test_url_should_return_non_secure_flickr_url
    obj = ::Faces::Providers::Flickr.new
    url = obj.url('12037949754@N01', {:flickr_api_key => '5ad55b17c6964b3c83651522576af9ca'})
    assert_match 'static.flickr.com', url
    assert_match 'http://farm', url
  end
  
  ####################
  #--- html       ---#
  ####################
  def test_html_should_return_non_secure_flickr_html
    obj = ::Faces::Providers::Flickr.new
    html = obj.html('12037949754@N01', {:flickr_api_key => '5ad55b17c6964b3c83651522576af9ca'})
    assert_match 'static.flickr.com', html
    assert_match '<img src="http://farm', html
  end
  
  ####################
  #--- exists?    ---#
  ####################
  def test_exists_should_return_true_if_avatar_exists
    obj = ::Faces::Providers::Flickr.new
    result = obj.exists?('12037949754@N01', {:flickr_api_key => '5ad55b17c6964b3c83651522576af9ca'})
    assert_equal true, result, 'Avatar does exist, should have returned true'
  end
end