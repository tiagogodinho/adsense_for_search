require 'action_view'
require 'adsense_for_search'

module AdSenseForSearch
  autoload :ViewHelper, 'adsense_for_search/view_helper'
  
  class << self
    attr_accessor :pubId, :channel
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
end