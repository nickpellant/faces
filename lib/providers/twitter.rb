module Faces
  module Configuration
    # Default configuration for twitter images
    TWITTER = {
      # Additional classes if desired
      :additional_classes => 'twitter'
    }
  end
  module Providers
    class Twitter
      def src(username, config = {})
        # Merge all possible configuration options
        config = merged_config(config)
        hostname + username + '_' + calculate_size(config)
      end
    
      def image_tag(username, config = {})
        config = merged_config(config)
        image = Faces::Public.image_tag(src(username, config), config)
      end
    
      def merged_config(config)
        @config ||= Faces::Common.merge_configurations([Faces::Configuration::TWITTER, config])
      end
    
      def exists?(identifier); true; end
      
      def allow_url?; true; end
      def allow_image?; true; end

    private
      def hostname
        'http://img.tweetimag.es/i/'
      end
     
      def calculate_size(config)
        # Mini
        if config[:size] <= 24
          'm'
        # Normal
        elsif config[:size] <= 48
          'n'
        # Large
        elsif config[:size] <= 73
          'b'
        # Original
        elsif config[:size] > 73
          'o'
        end
      end
    end
  end
end