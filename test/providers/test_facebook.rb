require File.dirname(__FILE__) + '/../test_helper'

class FacebookTest < Test::Unit::TestCase

  ####################
  #--- html       ---#
  ####################
  def test_html_should_return_facebook_html
    obj = ::Faces::Providers::Facebook.new
    html = obj.html('711246611')
    assert_match '<fb:profile-pic uid="', html
  end
  
  ####################
  #--- size       ---#
  ####################
  def test_size_should_return_square
    obj = ::Faces::Providers::Facebook.new
    assert_equal 'square', obj.__send__(:size, {:size => 50})
  end
  
  def test_size_should_return_small
    obj = ::Faces::Providers::Facebook.new
    assert_equal 'small', obj.__send__(:size, {:size => 100})
  end
  
  def test_size_should_return_normal
    obj = ::Faces::Providers::Facebook.new
    assert_equal 'normal', obj.__send__(:size, {:size => 150})
  end

  def test_size_should_return_square_when_set_to_square_only
    obj = ::Faces::Providers::Facebook.new
    assert_equal 'square', obj.__send__(:size, {:size => 150, :dimension_restriction => 'square-only'})
  end
end