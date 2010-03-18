module Faces
  module Configuration
    # Configuration for Flickr avatars
    FLICKR = {
      # Required to use the Flickr provider
      :flickr_api_key => '',
      # Additional HTML classes specific to Twitter provider (merged with :html_classes)
      :html_provider_classes => 'twitter'
    }
  end
  module Providers
    # Flickr class handles all Flickr based avatar methods, check the information page for more details:
    # http://nickpellant.com/open-source/faces/ruby/providers/flickr
    #
    # Default required methods for providers are +url+ and/or +html+, +exists?+
    # All other methods are at the discretion of the developer
    # Check the provider creation guide for more details:
    # http://nickpellant.com/open-source/faces/ruby/developing-providers
    class Flickr
      # Constructs Flickr url from user_id/configuration
      def url(user_id, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::FLICKR, configuration])
        hostname(flickr_avatar_details(user_id, m_configuration)) + user_id + '.jpg'
      end
      # Constructs HTML <img /> tag for Flickr
      def html(user_id, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::FLICKR, configuration])
        Faces::Public.generate_html(url(user_id, configuration), m_configuration)
      end
      # Checks Avatar exists
      def exists?(user_id, configuration = {})
        url = URI.parse(url(user_id, configuration))
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
        request = Net::HTTP::Get.new(url.path)
        response = http.request(request)
        response.code == '200' ? true : false
      end
      # Doesn't support SSL
      def ssl?; false; end
    private
      # Fetches the buddyicon farm details based on the user_id given
      # An avatar can not be pulled from Flickr without this method
      def flickr_avatar_details(user_id, m_configuration = {})
        url = URI.parse('http://api.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=' + m_configuration[:flickr_api_key] + '&user_id=' + user_id)
        xml = Net::HTTP.get_response(url).body
        doc = REXML::Document.new(xml)
        { :icon_server => doc.root.elements['person'].attributes['iconserver'], :icon_farm => doc.root.elements['person'].attributes['iconfarm'] }
      end
      # Constructs appropriate hostname based on return of flickr_avatar_details
      def hostname(flickr_details)
        'http://farm' + flickr_details[:icon_farm] + '.static.flickr.com/' + flickr_details[:icon_server] + '/buddyicons/'
      end
    end
  end
end