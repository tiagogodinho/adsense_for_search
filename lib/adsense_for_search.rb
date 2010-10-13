require 'action_view'
require 'adsense_for_search'

module AdSenseForSearch
  autoload :ViewHelper, 'adsense_for_search/view_helper'
end

ActionView::Base.send :include, AdSenseForSearch::ViewHelper

