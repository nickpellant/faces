module Faces
  module Configuration
    # Configuration for facebook avatars
    FACEBOOK = {
      # Show facebook logo
      :facebook_logo      => false,
      # Additional HTML classes specific to Facebook provider (merged with :html_classes)
      :html_provider_classes => 'facebook',
      # Link back to Facebook automatically?
      :facebook_auto_linked => false    
    }
  end
  module Providers
    # Facebook class handles all Facebook based avatar methods, check the information page for more details:
    # http://nickpellant.com/open-source/faces/ruby/providers/facebook
    #
    # Default required methods for providers are +url+ and/or +html+, +exists?+
    # All other methods are at the discretion of the developer
    # Check the provider creation guide for more details:
    # http://nickpellant.com/open-source/faces/ruby/developing-providers
    class Facebook
      # Constructs FBML tag for avatar
      def html(user_id, configuration = {})
        m_configuration = Faces::Common.merge_configurations([Faces::Configuration::FACEBOOK, configuration])
        fbml = '<fb:profile-pic uid="' + user_id + '" facebook-logo="' + m_configuration[:facebook_logo].to_s + '" linked="' + m_configuration[:facebook_auto_linked].to_s +
          '" size="' + size(m_configuration) + '" class="' + m_configuration[:html_classes] + ' ' + m_configuration[:html_provider_classes] + '"'
        fbml += m_configuration[:html_id] if m_configuration[:html_id].present?
        fbml += '"></fb:profile-pic>'
      end
      # Botch job as it's not possible to check for FBML avatar presence :(
      def exists?(identifier); true; end
    private
      # Calculates the size of image to pull from Facebook
      # This is decided based on the configuration settings of Faces
      def size(m_configuration = {})
        # Square avatar
        if m_configuration[:size] <= 50
          'square'
        # Small avatar
        elsif m_configuration[:size] <= 100 && m_configuration[:dimension_restriction] != 'square-only'
          'small'
        # Normal size
        elsif m_configuration[:size] > 100 && m_configuration[:dimension_restriction] != 'square-only'
          'normal'
        # Default back to square
        else
          'square'
        end
      end
    end
  end
end