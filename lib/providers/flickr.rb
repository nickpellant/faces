module Faces
  module Configuration
    # Default configuration for flickr images
    FLICKR = {
      :flickr_api_key     => '98170ee24764224d926092360a20da8f',
      # Additional classes if desired
      :additional_classes => 'flickr'
    }
  end
  module Providers
    class Flickr
      def src(id, config = {})
        # Merge all possible configuration options
        config = Faces::Common.merge_configurations(Faces::Configuration::FLICKR, config)
        hostname(fetch_avatar_details(id, config)) + id + '.jpg'
      end
    
      def image_tag(id, config = {})
        src   = src(id, config)
        image = Faces::Public.image_tag(src, config)
      end
        
      def allow_url?; true; end
      def allow_image?; true; end
    private
    
      def fetch_avatar_details(id, config)
        xml_data = Net::HTTP.get_response(URI.parse('http://api.flickr.com/services/rest/?method=flickr.people.' + 
        'getInfo&api_key=' + config[:flickr_api_key] + '&user_id=' + id)).body
        doc = REXML::Document.new(xml_data)
        {
          :icon_server => doc.root.attributes['iconserver'],
          :icon_farm => doc.root.attributes['iconfarm'],
        }
      end
        
      def hostname(details)
        'http://farm' + details[:icon_farm] + '.static.flickr.com/' + details[:icon_server] + '/buddyicons/'
      end
    end
  end
end