module Faces
  module Configuration
    # Default configuration for facebook images
    FACEBOOK = {
      # Show facebook logo
      :facebook_logo      => 'false',
      # Additional classes if desired
      :additional_classes => 'facebook',
      # Link back to facebook automatically?
      :linked => 'false'      
    }
  end
  module Providers
    class Facebook
      def image_tag(id, config = {})
        config = Faces::Common.merge_configurations([Faces::Configuration::FACEBOOK, config])
        image = '<fb:profile-pic uid="' + id + '" facebook-logo="' + config[:facebook_logo] + '" linked="' + config[:linked] +
          '" size="' + calculate_size(config) + '" class="' + config[:classes] + ' ' + config[:additional_classes] +
          '"></fb:profile-pic>'
      end
    
      def exists?(identifier); true; end
    
      def allow_url?; false; end
      def allow_image?; true; end
      
    private
      def calculate_size(config)
        # Mini
        if config[:size] <= 50
          'square'
        # Normal
        elsif config[:size] <= 100
          'small'
        # Large
        elsif config[:size] <= 200
          'normal'
        end
      end
    end
  end
end