require 'action_view'
require 'ad_sense_for_search'

module AdSenseForSearch
  autoload :ViewHelper, 'ad_sense_for_search/view_helper'
end

ActionView::Base.send :include, AdSenseForSearch::ViewHelper

