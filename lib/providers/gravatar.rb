module Faces
  module Configuration
    # Configuration for Gravatar avatars
    GRAVATAR = {
      # Apply a Gravatar rating requirement ('G', 'PG', 'R', 'X')
      # We default to 'G' to remain consistant with Gravatar
      :gravatar_rating       => 'G',
      # Additional HTML classes specific to Gravatar provider (merged with :html_classes)
      :html_provider_classes => 'gravatar'
    }
  end
  module Providers
    # Gravatar class handles all Gravatar based avatar methods, check the information page for more details:
    # http://nickpellant.com/open-source/faces/ruby/providers/gravatar
    #
    # Default required methods for providers are +url+ and/or +html+, +exists?+
    # All other methods are at the discretion of the developer
    # Check the provider creation guide for more details:
    # http://nickpellant.com/open-source/faces/ruby/developing-providers
    class Gravatar
      # Constructs Gravatar url from email/configuration
      # It can be passed either an MD5 hash as email or a string email
      def url(email, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::GRAVATAR, configuration])
        email = md5_email(email) if email.include? "@"
        url = hostname(m_configuration) + email + build_params_string(m_configuration)
      end
      # Constructs HTML <img /> tag for Gravatar
      def html(email, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::GRAVATAR, configuration])
        Faces::Public.generate_html(url(email, configuration), m_configuration)
      end
      # Checks Avatar exists
      def exists?(email, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::GRAVATAR, configuration, {:default => '404'}])
        url = URI.parse(url(email, m_configuration))
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
        request = Net::HTTP::Get.new(url.path + '?' + url.query)
        response = http.request(request)
        response.code == '200' ? true : false
      end
      # Supports SSL
      def ssl?; true; end
      # Formats email and converts into MD5 hash for use with Gravatar url
      def md5_email(email)
        Digest::MD5.hexdigest(email.strip.downcase)
      end
    private
      # Constructs appropriate hostname based on secure preferences
      def hostname(m_configuration = {})
        'http' + (m_configuration[:use_secure] ? 's://secure.' : '://') + 'gravatar.com/avatar/'
      end
      # Build url parameters string
      def build_params_string(m_configuration = {})
        # Set the size of the avatar we want to fetch
        Faces::Common.build_param('s', m_configuration[:size], true) + 
          # Set the rating of the avatar we want to fetch
          Faces::Common.build_param('r', m_configuration[:gravatar_rating])  +
          # Default image to defer too (or possibily a generator in the case of Gravatar)
          Faces::Common.build_param('d', m_configuration[:default])
      end
    end
  end
end