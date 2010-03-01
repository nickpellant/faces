module Faces
  module Configuration
    # Configuration for gravatar images
    GRAVATAR = {
      # Apply a rating requirement
      :rating             => 'PG',
      # Additional classes if desired
      :additional_classes => 'gravatar'
    }
  end
  module Providers
    class Gravatar
      def src(email, config = {})
        # Merge all possible configuration options
        config = merged_config(config)
        hostname(config) + id(email) + build_params_string(config)
      end
    
      def id(email)
        Digest::MD5.hexdigest(email)
      end
    
      def merged_config(config)
        @config ||= Faces::Common.merge_configurations([Faces::Configuration::GRAVATAR, config])
      end
    
      def image_tag(email, config = {})
        config = merged_config(config)
        image = Faces::Public.image_tag(src(email, config), config)
      end
    
      def exists?(email)
        if Net::HTTP.get_response(URI.parse(src(email, {:default => '404'}))).code != "200"
          false
        else
          true
        end
      end
      
      def allow_url?; true; end
      def allow_image?; true; end
            
    private
      def hostname(config)
        'http' + (config[:secure] ? 's://secure.' : '://') + 'gravatar.com/avatar/'
      end
     
      def build_params_string(config)
        # Size of the avatar
        Faces::Common.build_param('s', config[:size], true) + 
          # Rating identifier of the avatar
          Faces::Common.build_param('r', config[:rating])  +
          # Default image to defer too (or generator, in this case)
          Faces::Common.build_param('d', config[:default])
      end
    end
  end
end