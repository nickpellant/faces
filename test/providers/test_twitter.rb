require File.dirname(__FILE__) + '/../test_helper'

class TwitterTest < Test::Unit::TestCase

  ####################
  #--- url        ---#
  ####################
  def test_url_should_return_non_secure_tweetimages_url
    obj = ::Faces::Providers::Twitter.new
    url = obj.url('npellant')
    assert_match 'http://img.tweetimag.es/i/', url
  end
  
  ####################
  #--- html       ---#
  ####################
  def test_html_should_return_twitter_image_html
    obj = ::Faces::Providers::Twitter.new
    html = obj.html('npellant')
    assert_match '<img src="http://img.tweetimag.es/i/', html
  end
  
  ####################
  #--- exists?    ---#
  ####################
  def test_exists_should_return_true_if_avatar_exists
    obj = ::Faces::Providers::Twitter.new
    result = obj.exists?('npellant')
    assert_equal true, result, 'Avatar does exist, should have returned true'
  end
  
  ####################
  #--- size       ---#
  ####################
  def test_size_should_return_mini
    obj = ::Faces::Providers::Twitter.new
    assert_equal 'm', obj.__send__(:size, {:size => 24})
  end
  
  def test_size_should_return_normal
    obj = ::Faces::Providers::Twitter.new
    assert_equal 'n', obj.__send__(:size, {:size => 48})
  end
  
  def test_size_should_return_big
    obj = ::Faces::Providers::Twitter.new
    assert_equal 'b', obj.__send__(:size, {:size => 73})
  end

  def test_size_should_return_original
    obj = ::Faces::Providers::Twitter.new
    assert_equal 'o', obj.__send__(:size, {:size => 100})
  end
  
  def test_size_should_return_big_when_set_to_square_only
    obj = ::Faces::Providers::Twitter.new
    assert_equal 'b', obj.__send__(:size, {:size => 100, :dimension_restriction => 'square-only'})
  end
end