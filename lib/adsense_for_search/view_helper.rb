# encoding: utf-8

module AdSenseForSearch
  module ViewHelper
    def adsense_for_search(*options)
      raise ArgumentError, "AdSense for search needs a query string" unless options.first

      pageOptions = {
        :pubId => AdSenseForSearch.pubId,
        :query => options.first
      }
      
      pageOptions.merge!(:channel => AdSenseForSearch.channel) if AdSenseForSearch.channel
      pageOptions.merge!(:adtest => 'on') unless Rails.env == 'production'
      
      pageOptions.merge! options.last[:options] if options.last.has_key? :options

      adblock1 = {
        :container => 'adblock1',
        :number => 3,
        :width => 'auto',
        :lines => 2,
        :fontFamily => 'arial',
        :fontSizeTitle => '14px',
        :fontSizeDescription => '14px',
        :fontSizeDomainLink => '14px'
      }

      adblock1.merge! options.last[:adblock1] if options.last.has_key? :adblock1

      adblock2 = {
        :container => 'adblock2',
        :number => 4,
        :width => '250px',
        :lines => 3,
        :fontFamily => 'arial',
        :fontSizeTitle => '12px',
        :fontSizeDescription => '12px',
        :fontSizeDomainLink => '12px'
      }

      adblock2.merge! options.last[:adblock2] if options.last.has_key? :adblock2
      
      adblock3 = {
        :container => 'adblock3',
        :number => 3,
        :width => 'auto',
        :lines => 2,
        :fontFamily => 'arial',
        :fontSizeTitle => '14px',
        :fontSizeDescription => '14px',
        :fontSizeDomainLink => '14px'
      }

      adblock3.merge! options.last[:adblock3] if options.last.has_key? :adblock3

      js = ""
      js << "var pageOptions = #{pageOptions.to_json2};\n"
      js << "\n  var adblock1 = #{adblock1.to_json2};\n" if options.last.has_key? :adblock1
      js << "\n  var adblock2 = #{adblock2.to_json2};\n" if options.last.has_key? :adblock2
      js << "\n  var adblock3 = #{adblock3.to_json2};\n" if options.last.has_key? :adblock3
      js << "\n  new google.ads.search.Ads(pageOptions#{ ', adblock1' if options.last.has_key? :adblock1 }#{ ', adblock2' if options.last.has_key? :adblock2 }#{ ', adblock3' if options.last.has_key? :adblock3 });"

      <<-javascript
<script type="text/javascript" charset="utf­8">
  #{js}
</script>
      javascript
    end
  end
end

