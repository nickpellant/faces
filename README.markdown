# Faces

<small>The easiest implementation for Avatars in ruby. By [Nick](http://nickpellant.com).</small>

Faces utilizes external avatar sources to provide you with the widest range of options for your users avatar. Faces currently supports the following providers;

* [Gravatar](http://gravatar.com)
* [Twitter](http://twitter.com) (via [Tweet Images](http://tweetimag.es/) API)
* [Facebook](http://facebook.com)
* [Flickr](http:/flickr.com)

Each of the providers are explained below if they have special needs. In general though pulling an avatar is as easy as;

    avatar_html(identifier, provider, config = {}) # Gives image html tag
    avatar_url(identifier, provider, config = {}) # Gives avatar url

Faces is setup to allow developers to add providers quickly and easily. If you do add a provider and you think it would be useful to the collective, make sure to shoot over a pull request.

## Public methods

To generate an avatar image html tag:

    avatar_html(identifier, provider, config = {})

To generate an avatar url:

    avatar_url(identifier, provider, config = {})
    
To generate the default avatar html tag:

    avatar_default_html(identifier, provider, config = {})
    
To generate the default avatar url tag:

    avatar_default_url(identifier, provider, config = {})

To check whether a provider is supported (by default or by plugin):

    provider_exists?(provider)    

To check whether an avatar exists:

    avatar_exists?(identifier, provider)

To generate an image tag directly with an src (useful for unsupported providers):

    avatar_exists?(src, config = {})

## Install

    sudo gem install faces
    
Add this to your `environment.rb`:

    config.gem 'faces', :version => '>= 1.0'

## Configuration

Faces by default sets some universal configuration values however you may want to change these to your needs. To change the default configurations the easiest way is to setup an initializer. Here is an example for changing the default picture URL (one which everyone is advised to do to avoid blank images).

    Faces::Configuration::UNIVERSAL[:default] = 'http://dummy.host/images/default.png'
  
Also to use certain providers you are required to add certain values. For instance with Flickr you must give an API key.

    Faces::Configuration::FLICKR[:flickr_api_key] = 'flickrkeygoeshere123'

You can also override any universal configuration for a specific provider, if so desired.

### Universal

The following configuration options are available for setting universally:

* default   - If an avatar is unavailable, we defer to this url. ['']
* size      - Default avatar dimensions in pixels. If avatar is not square, this is used as a max point for either height/width. [50]
* classes   - Base classes to be assigned to all faces avatars ['faces avatar']
* secure    - Use a secure connection when one is available? [false]
* file_type - If possible we will use this file type with the providers ['']

### Gravatar

The following configuration options are available for setting to Gravatars:

* rating             - Top rating allowed for gravatars. ['PG']
* additional_classes - Additional classes to be assigned (on-top of universal classes) ['gravatar']

#### Further reading

* [Gravatar URL construction](http://en.gravatar.com/site/implement/url)

### Twitter

The following configuration options are available for setting to Twitter:

* additional_classes - Additional classes to be assigned (on-top of universal classes) ['twitter']

Twitter avatar sizes are calculated dynamically. Available sizes are 24x24, 48x48, 73x73 and the original size. Faces calculates which of the available sizes provided by twitter best matches the dimensions you provided us in universal settings.

#### Further reading

* [Tweet Images](http://tweetimag.es/)

### Facebook

The following configuration options are available for setting to Facebook:

* additional_classes - Additional classes to be assigned (on-top of universal classes) ['facebook']
* facebook_logo      - Whether you want the facebook logo overlaid on-top of the avatar ['true' or 'false']
* linked             - Whether you want the avatar to link to the persons facebook profile ['true' or 'false']

To get Facebook working you will also need a Facebook application and add the following to your application before you close the body tag;

    <script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_GB" type="text/javascript"></script>
    <script type="text/javascript">FB.init("PUBLIC API KEY HERE");</script>
       
Make sure you have setup Facebook Connect with the site url and base url in the application settings correctly otherwise it will not work!

You will also need to add the following to your html tag;

    xmlns:fb="http://www.facebook.com/2008/fbml"

#### Further reading

* [Fb:profile-pic Documentation](http://wiki.developers.facebook.com/index.php/Fb:profile-pic)

### Flickr

The following configuration options are available for setting to Flickr:

* flickr\_api\_key   - API key for using Flickr API ['afdbdfopgp4psgvwrcop']
* additional_classes - Additional classes to be assigned (on-top of universal classes) ['twitter']

Flickr only provides avatars at 48x48 - remember if you're using a higher size than this there will be pixilation.

#### Further reading

* [Flickr Buddyicons](http://www.flickr.com/services/api/misc.buddyicons.html)