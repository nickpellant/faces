module Faces
  module Configuration
    # Configuration for highrise avatars
    HIGHRISE = {
      # Base account name (http://accountname.highrisehq.com)
      :highrise_account_name => '',
      # Additional HTML classes specific to Highrise provider (merged with :html_classes)
      :html_provider_classes => 'highrise'
    }
  end
  module Providers
    # Highrise class handles all Highrise based avatar methods
    # Default required methods for providers are +url+ and/or +html+, +exists?+
    # All other methods are at the discretion of the developer
    # Check the provider creation guide for more details:
    # http://nickpellant.com/open-source/faces/ruby/developing-providers
    class Highrise
      # Constructs Highrise url from contact_id/configuration
      def url(contact_id, configuration = {})
        m_configuration =  Faces::Common.merge_configurations([Faces::Configuration::HIGHRISE, configuration])
        hostname(m_configuration) + contact_id[0..3] + '/' + contact_id[4..-1] + '-' + size(m_configuration) + '.png'
      end
      # Constructs HTML <img /> tag for Highrise avatar
      def html(contact_id, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::HIGHRISE, configuration])
        Faces::Public.generate_html(url(contact_id, configuration), m_configuration)
      end
      # Supports SSL
      def ssl?; true; end
      # Checks Avatar exists
      def exists?(contact_id, configuration = {})
        url = URI.parse(url(contact_id, configuration))
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
        request = Net::HTTP::Get.new(url.path)
        response = http.request(request)
        response.code == '200' ? true : false
      end
    private
      # Constructs appropriate hostname based on secure preferences and account name
      def hostname(m_configuration)
        'http' + (m_configuration[:use_secure] ? 's' : '') + "://" + m_configuration[:highrise_account_name] + ".highrisehq.com/dl/avatars/person/"
      end
      # Calculates the size of image to pull from Highrise
      # This is decided based on the configuration settings of Faces
      def size(m_configuration)
        m_configuration[:size] <= 32 ? 'small' : 'large'
      end
    end
  end
end