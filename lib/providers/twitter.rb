module Faces
  module Configuration
    # Configuration for Twitter avatars
    TWITTER = {
      # Additional HTML classes specific to Twitter provider (merged with :html_classes)
      :html_provider_classes => 'twitter'
    }
  end
  module Providers
    # Twitter class handles all Twitter based avatar methods, check the information page for more details:
    # http://nickpellant.com/open-source/faces/ruby/providers/twitter
    #
    # Default required methods for providers are +url+ and/or +html+, +exists?+
    # All other methods are at the discretion of the developer
    # Check the provider creation guide for more details:
    # http://nickpellant.com/open-source/faces/ruby/developing-providers
    class Twitter
      # Constructs Twitter url from username/configuration
      def url(username, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::TWITTER, configuration])
        'http://img.tweetimag.es/i/' + username + '_' + size(m_configuration)
      end
      # Constructs HTML <img /> tag for Twitter
      def html(username, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::TWITTER, configuration])
        Faces::Public.generate_html(url(username, configuration), m_configuration)
      end
      # Doesn't support SSL
      def ssl?; false; end
      # Checks Avatar exists
      def exists?(username, configuration = {})
        url = URI.parse(url(username, configuration))
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
        request = Net::HTTP::Get.new(url.path)
        response = http.request(request)
        response.code == '200' ? true : false
      end
    private
      # Calculates the size of image to pull from Twitter
      # This is decided based on the configuration settings of Faces
      def size(m_configuration = {})
        # Mini sized
        if m_configuration[:size] <= 24
          'm'
        # Normal sized
        elsif m_configuration[:size] <= 48
          'n'
        # Large sized
        elsif m_configuration[:size] <= 73
          'b'
        # Originally uploaded image
        elsif m_configuration[:size] > 73 && m_configuration[:dimension_restriction] != 'square-only'
          'o'
        # Default back to large size for anything above 73px but still square requirement
        else
          'b'
        end
      end
    end
  end
end