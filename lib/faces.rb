require File.dirname(__FILE__) + '/providers/gravatar'
require File.dirname(__FILE__) + '/providers/twitter'
require File.dirname(__FILE__) + '/providers/facebook'
require File.dirname(__FILE__) + '/providers/flickr'

require 'net/http'
require 'rexml/document'
require 'digest/md5'

module Faces
  module Public
    def avatar_html(identifier, provider, config = {})
      obj = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
      obj.image_tag(identifier, config)
    end
    
    def avatar_url(identifier, provider, config = {})
      obj = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
      obj.src(identifier, config)
    end
    
    def avatar_default_html(config = {})
      src = config[:default].present? ? config[:default] : ::Faces::Configuration::UNIVERSAL[:default]
      image_tag(src, config)
    end
    
    def avatar_default_url(config = {})
      config[:default].present? ? config[:default] : ::Faces::Configuration::UNIVERSAL[:default]
    end
    
    def provider_exists?(provider)
      true if ::Faces::Providers.const_get("#{provider.to_s.classify}")
    rescue NameError
      false
    end
  
    def avatar_exists?(identifier, provider)
      obj = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
      obj.exists?(identifier)
    end
    
    def image_tag(src, config = {})
      config = Faces::Common.merge_configurations([Faces::Configuration::UNIVERSAL, config])
      classes = config[:additional_classes].present? ? config[:classes] + ' ' + config[:additional_classes] : config[:classes]
      
      tag = '<img src="' + src + '" class="' + classes + '"'
      tag += 'id="' + config[:id] + '"' if config[:id].present?
      tag += ' />'
    end
    
    module_function :avatar_exists?, :provider_exists?, :avatar_url, :avatar_html, :image_tag, :avatar_default_html, :avatar_default_url
  end
  
  module Configuration
    # Universal configuration for avatars
    UNIVERSAL = {
      # If a avatar is unavailable for the provided details
      :default    => '',
      # Default avatar dimensions in pixels (always returns square)
      :size       => 50,
      # CSS class(es) to be assigned to image tags
      :classes    => 'faces avatar',
      # Use a secure connection when one is available
      :secure     => false,
      # If possible we will use this file type ending with our providers (png, jpeg, etc.)
      :file_type  => ''
    }
  end
  
  module Common
    # Merges together all configurations given from first to last in order of priority
    def merge_configurations(configurations)
      configuration = Faces::Configuration::UNIVERSAL
      configurations.each do |config|
        configuration = configuration.merge!(config)
      end
      configuration
    end
    
    def build_param(key, value, first = false)
      if value.present?
        first == true ? "?#{key}=#{value}" : "&#{key}=#{value}"
      else
        ''
      end
    end
    
    module_function :merge_configurations, :build_param
  end
end