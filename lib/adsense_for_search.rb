require 'action_view'
require 'adsense_for_search'

module AdSenseForSearch
  autoload :ViewHelper, 'adsense_for_search/view_helper'
  
  class << self
    attr_accessor :pubId, :channel
    
    def config(config = :default)
      yml = YAML.load_file(config_file || default_config_file).deep_symbolize_keys[config]
    end
    
    def default_config_file
      'lib/adsense_for_search/adsense_for_search.yml'
    end
    
    def config_file=(path)
      @config = path
    end
    
    def config_file
      path = File.join(Rails.root, 'config', 'adsense_for_search.yml').to_s unless Rails.root.nil?
      @config ||= path
    end
  end
end

ActionView::Base.send :include, AdSenseForSearch::ViewHelper

class Hash
  def to_json2
    result = []
    
    each do |key, value|
      string = "\"#{key}\":"
      string << ((value.class.to_s == "String") ? "\"#{value}\"" : "#{value}")
      
      result << string
    end
    
    "{#{result.join(',')}}"
  end
  
  def deep_symbolize_keys
    inject({}) { |result, (key, value)|
      value = value.deep_symbolize_keys if value.is_a?(Hash)
      result[(key.to_sym rescue key) || key] = value
      result
    }
  end unless Hash.method_defined?(:deep_symbolize_keys)
  
  MERGER = proc do |key, v1, v2|
    Hash === v1 && Hash === v2 ? v1.merge(v2, &MERGER) : v2
  end
  
  def deep_merge!(data)
    merge!(data, &MERGER)
  end unless Hash.method_defined?(:deep_merge!)
end
