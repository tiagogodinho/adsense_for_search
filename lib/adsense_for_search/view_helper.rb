# encoding: utf-8

module AdSenseForSearch
  module ViewHelper
    def adsense_for_search(query, options = {})
      raise ArgumentError, "AdSense for search needs a query string" if query.nil?
      
      configurations = AdSenseForSearch.config
      
      pageOptions = { :query => query }
      pageOptions.merge!(:adtest => 'on') unless Rails.env == 'production'
      configurations.deep_merge!(:pageOptions => pageOptions)
      
      configurations.deep_merge!(options)
      
      variables = ['pageOptions']
      variables << 'adblock1' if configurations[:adblock1]
      variables << 'adblock2' if configurations[:adblock2]
      variables << 'adblock3' if configurations[:adblock3]
      
      js = ""
      js << "var pageOptions = #{ configurations[:pageOptions].to_json2 };\n"
      js << "\n  var adblock1 = #{ configurations[:adblock1].to_json2 };\n" if configurations[:adblock1]
      js << "\n  var adblock2 = #{ configurations[:adblock2].to_json2 };\n" if configurations[:adblock2]
      js << "\n  var adblock3 = #{ configurations[:adblock3].to_json2 };\n" if configurations[:adblock3]
      js << "\n  new google.ads.search.Ads(#{variables.join(', ')});"
      
      output = <<-javascript
<script type="text/javascript" charset="utf-8">
  #{js}
</script>
      javascript
      
      output.html_safe
    end
  end
end
