# Faces

<small>Avatars made easy, by [Nick Pellant](http://nickpellant.com).</small>

Faces is an avatar provider/management library. It allows developers to fetch avatars from multiple sources in a consistent manner. Faces was built to rectify a problem originally faced when improving the avatars system at [Silentale](http://silentale.com). Faces has default support for the following avatar sources:

* [Facebook](http://facebook.com)
* [Twitter](http://twitter.com) via [Tweet Images](http://tweetimag.es/)
* [Highrise](http://highrisehq.com)
* [Flickr](http:/flickr.com)
* [Gravatar](http://gravatar.com)

Faces is now available in both [Ruby](http://github.com/nickpellant/faces) and [PHP](http://github.com/nickpellant/faces-php) with a Python version in its way soon. As Faces is available in multiple languages provider support may vary from one project to another however it will be attempted to keep default provider support synchronized.

## Public methods

    avatar_url(identifier, provider, configuration = {})

The **avatar\_url** method is an accessor point to pull an avatar from a provider. The method will only return a value if the provider exists and the **url** method exists for the provider, otherwise it will return the default avatar url (**avatar\_default\_url**).

    avatar_html(identifier, provider, configuration = {})

The **avatar\_html** method is an accessor point to pull an avatar from a provider and encase it in a img html tag. It will also add any configurations you've set regarding markup to the tag. The method will only return a value if the provider exists and the **html** method exists for the provider, otherwise it will return the default avatar html (**avatar\_default\_html**).

    generate_html(url, configuration = {})
  
The **generate\_html** method allows you to pass an avatar URL for which a provider does not exist so as to use the Faces configuration architecture, allowing you to keep a level of consistency. (We do suggest however you build your own providers directly, as it's a hell of a lot cooler)

    avatar_default_url(configuration = {})

The **avatar\_default\_url** method returns the default avatar url.
 
    avatar_default_html(configuration = {})

The **avatar\_default\_html** method returns the default avatar html img tag.

    avatar_exists?(identifier, provider, configuration = {})

The **avatar\_exists?** method returns true/false as to whether an avatar exists for the given details.

    provider_exists?(provider)

The **provider\_exists?** method returns true/false as to whether a provider with the given string exists and is available.

    provider_method_exists?(method, provider)

The **provider\_method\_exists?** method returns true/false as to whether said method exists for said provider (also returns false if provider does not exist).

### Note

Make sure to check out the relevant documentation for each provider. Providers are standardized as much as possible but there are sometimes special requirements (Flickr requires an API key in it's configuration, for example).

## Installation

Install the gem (**Recommended**)

    sudo gem install faces

### Ruby on Rails

Add this to your `environment.rb` (gem setup only)

    config.gem 'faces', :version => '>= x.x'

If you don't like gems for some reason, install it as a plugin

    script/plugin install git://github.com/nickpellant/faces.git

We also suggest you setup your configuration via an initializer (find an example file on how to do this in the 'examples/rails' folder)

## Configuration options

Faces has a hierarchy system for configuration. We start of with a universal configuration and gradually override as we go down the chain like so:

**Custom Configuration (method set)** > **Provider Configuration** > **Universal Configuration** 

Faces by default sets a whole bunch of values for provider & universal configurations, but we highly recommend you change them to suit your needs. I've listed the universal ones below and provider specific configuration options with their provider documentations.

  * ::Faces::Configuration::UNIVERSAL
    * Fallback avatar url (string)
      * :default      => 'http://www.gravatar.com/avatar/?d=identicon'
    * Max dimension constraints for width/height of avatar (integer)
      * :size         => 50
    * Universally assigned classes to all avatars (string)
      * :html\_classes => 'faces avatars'
    * Use secure connection where possible (boolean)
      * :html\_classes => false
    * Restrict dimensions, to activate set 'square-only' (string)
      * :dimension\_restriction => ''

## Facebook Provider

The Facebook provider supports all the functionality available from it's API. It supports only **html** calls however (which are, in fact FBML, but we keep the name for sake of consistency).

There are a few additional configuration options available for Facebook that you may want to look at.
  
  * ::Faces::Configuration::FACEBOOK
    * Layer facebook logo ontop of avatar (boolean)
      * :facebook\_logo => false
    * Auto-link avatar back to Facebook (boolean)
      * :facebook\_auto\_linked => false
    * Provider specific html classes (string)
      * :html\_provider\_classes => 'facebook'

To get this provider working you will also need a Facebook application/API key (this is because the provider uses FBML to generate it's avatars).

Once you have the application & API key add the following before the close of your body tag

    <script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_GB" type="text/javascript"></script>
    <script type="text/javascript">FB.init("INSERT PUBLIC API KEY HERE");</script>

Make sure you have setup Facebook Connect for your Facebook application with the site url and base url in the application settings. If they are setup incorrectly this will not work!

You will also need to add the following to your html tag to complete the setup

    xmlns:fb="http://www.facebook.com/2008/fbml"
    
Facebook avatar sizes are calculated dynamically from your configuration. Available sizes are 50x50, <=100 and >100. Faces calculates which of the available sizes provided by facebook best matches the dimensions you provided. If you select to receive only square images but choose a size over 50x50 there will be pixilation.

### Further reading

* [Full Facebook provider documentation](http://nickpellant.com/open-source/faces/ruby/provider/facebook)
* [Fb:profile-pic Documentation](http://wiki.developers.facebook.com/index.php/Fb:profile-pic)

## Twitter Provider

The Twitter provider uses the [Tweet Images](http://tweetimag.es/) mapper to provide urls (an awesome project from [Joe Stump](http://stu.mp)). It supports both **html** and **url** calls.

There are a few additional configuration options available for Twitter that you may want to look at.
  
  * ::Faces::Configuration::TWITTER
    * Provider specific html classes (string)
      * :html\_provider\_classes => 'twitter'
      
Twitter avatar sizes are calculated dynamically from your configuration. Available sizes are 24x24, 48x48, 73x73 and the original size. Faces calculates which of the available sizes provided by twitter best matches the dimensions you provided. If you select to receive only square images but choose a size over 73x73 you will be given the largest possible square avatar.
      
### Further reading

* [Full Twitter provider documentation](http://nickpellant.com/open-source/faces/ruby/provider/twitter)
* [Tweet Images](http://tweetimag.es/)

## Highrise Provider

Supports both **html** and **url** calls.

Highrise expects a **contact\_id** as it's identifier parameter. It also expects the configuration option `:highrise_account_name` to be set appropriately.

<small>_for those who do not know the account name for highrise is the subdomain, i.e. myaccountname.highrisehq.com_</small>

There are a few additional configuration options available for Highrise that you may want to look at.
  
  * ::Faces::Configuration::HIGHRISE
    * Provider specific html classes (string)
      * :html\_provider\_classes => 'highrise'

Highrise avatar sizes are calculated dynamically from your configuration. Available sizes are 32x32 and 53x53. Faces calculates which of the available sizes provided by Highrise best matches the dimensions you provided.

### Further reading

* [Full Highrise provider documentation](http://nickpellant.com/open-source/faces/ruby/provider/highrise)
* [Highrise API](http://developer.37signals.com/highrise/)

## Flickr Provider

The Flickr provider supports all the functionality of the API. It supports both **html** and **url** calls.

To have the Flickr provider working you will _need_ to set an API key.

  * ::Faces::Configuration::FLICKR
    * API key of application on Flickr (string)
      * :flickr\_api\_key => 'dzgasgji3ewaojodsgojw'

There are a few additional configuration options available for Flickr that you may want to look at.
  
  * ::Faces::Configuration::FLICKR
    * Provider specific html classes (string)
      * :html\_provider\_classes => 'flickr'

Flickr only provides avatars at 48x48 - if you're using a higher size than this there will be pixilation.

### Further reading

* [Full Flickr provider documentation](http://nickpellant.com/open-source/faces/ruby/provider/flickr)
* [Flickr Buddyicons](http://www.flickr.com/services/api/misc.buddyicons.html)

## Gravatar Provider

The Gravatar provider supports all the functionality available from it's API. It supports both **html** and **url** calls.

There are a few additional configuration options available for Gravatar that you may want to look at.
  
  * ::Faces::Configuration::GRAVATAR
    * Gravatar rating, minimum requirement (string)
      * :gravatar\_rating => 'G'
    * Provider specific html classes (string)
      * :html\_provider\_classes => 'gravatar'
      
### Further reading

* [Full Gravatar provider documentation](http://nickpellant.com/open-source/faces/ruby/provider/gravatar)
* [Gravatar URL construction](http://en.gravatar.com/site/implement/url)