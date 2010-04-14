Dir.glob(File.join(File.dirname(__FILE__), '/providers/*.rb')).each { |f| require f }

require 'net/http'
require 'net/https'
require 'rexml/document'
require 'digest/md5'
require 'cgi'

module Faces
  module Configuration
    # Universal configuration for avatars
    UNIVERSAL = {
      # Avatar to default to
      :default      => 'http://www.gravatar.com/avatar/?d=identicon',
      # Max height or width pixel size for returned avatar
      :size         => 50,
      # CSS classes to be assigned to all <img /> tags
      :html_classes => 'faces avatar',
      # Use a secure connection when one is available
      :use_secure   => false,
      # If we only ever want to return square images, set to square-only
      :dimension_restriction  => ''
    }
  end
  module Public
    # Returns the avatar in an <img /> HTML tag based on identifier, provider and configuration
    # Uses local provider classes to generate the result
    # Does not check for existance of Avatar, this is the responsibility of the developer
    def avatar_html(identifier, provider, configuration = {})
      if provider_method_exists?('html', provider)
        obj  = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
        obj.html(identifier, configuration)
      else
        avatar_default_html(configuration)
      end
    end
    # Returns avatar url based on identifier, provider and configuration
    # Uses local provider classes to generate the result
    # Does not check for existance of Avatar, this is the responsibility of the developer
    def avatar_url(identifier, provider, configuration = {})
      if provider_method_exists?('url', provider)
        obj = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
        obj.url(identifier, configuration) 
      else
        avatar_default_url(configuration)
      end
    end
    # Returns true if avatar exists, false if not 
    def avatar_exists?(identifier, provider, configuration = {})
      obj = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
      obj.exists?(identifier, configuration)
    end
    # Returns true if the provider has SSL available, else false
    def provider_supports_ssl?(provider)
      obj = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
      obj.respond_to?('ssl?') ? obj.ssl? : false
    end
    # Returns the default avatar in an <img /> HTML tag
    def avatar_default_html(configuration = {})
      default = configuration[:default].present? ? configuration[:default] : ::Faces::Configuration::UNIVERSAL[:default]
      url = configuration[:size].present? ? default[configuration[:size]] : default[::Faces::Configuration::UNIVERSAL[:size]]
      generate_html(url, configuration)
    end
    # Returns the default avatar as a url   
    def avatar_default_url(configuration = {})
      default = configuration[:default].present? ? configuration[:default] : ::Faces::Configuration::UNIVERSAL[:default]
      url = configuration[:size].present? ? default[configuration[:size]] : default[::Faces::Configuration::UNIVERSAL[:size]]
    end
    # Returns true if provider exists, false if not 
    def provider_exists?(provider)
      true if ::Faces::Providers.const_get("#{provider.to_s.classify}")
    rescue NameError
      false
    end
    # Returns true if provider method exists, false if not 
    def provider_method_exists?(method, provider)
      if ::Faces::Providers.const_get("#{provider.to_s.classify}")
        obj = "::Faces::Providers::#{provider.to_s.classify}".constantize.new
        obj.respond_to?(method) 
      end
    rescue NameError
      false
    end
    # Generates a HTML <img /> tag for the given url
    def generate_html(url, configuration = {})
      m_configuration = Faces::Common.merge_configurations([Faces::Configuration::UNIVERSAL, configuration])
      combined_classes = m_configuration[:html_provider_classes].present? ? m_configuration[:html_classes] + ' ' + m_configuration[:html_provider_classes] : m_configuration[:html_classes]

      html  = '<img src="' + url + '" class="' + combined_classes + '"'
      html += " id=\"#{m_configuration[:id]}\"" if m_configuration[:id].present?
      html += " width=\"#{m_configuration[:width]}\"" if m_configuration[:width].present?
      html += " height=\"#{m_configuration[:height]}\"" if m_configuration[:height].present?
      html += " alt=\"#{m_configuration[:alt]}\"" if m_configuration[:alt].present?
      html += ' />'
    end
    
    module_function :avatar_exists?, :provider_exists?, :provider_supports_ssl?, :provider_method_exists?, :avatar_url, :avatar_html, :generate_html, :avatar_default_html, :avatar_default_url
  end  
  module Common
    # Merges together all configurations given from first to last in order of priority
    def merge_configurations(configurations)
      configuration = Faces::Configuration::UNIVERSAL
      configurations.each do |config|
        configuration = configuration.merge(config)
      end
      configuration
    end
    # Builds a url query parameter string
    def build_param(key, value, first = false)
      value.present? ? (first == true ? "?#{key}=#{CGI.escape(value.to_s)}" : "&#{key}=#{CGI.escape(value.to_s)}") : ''
    end
    
    module_function :merge_configurations, :build_param
  end
end