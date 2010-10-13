# encoding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

require "adsense_for_search"

describe AdSenseForSearch do
  before :each do
    @view = ActionView::Base.new
  end

  it 'should be mixed into ActionView::Base' do
    ActionView::Base.included_modules.should include(AdSenseForSearch::ViewHelper)
  end

  it 'should respond to "title" helper' do
    @view.should respond_to(:adsense_for_search)
  end

  it 'should raise an error without query' do
    lambda { @view.adsense_for_search }.should raise_error(ArgumentError)
  end

  it 'should respond to "title" helper' do
    @view.adsense_for_search('emprego sorocaba', :adblock1 => {:number => 7}).should ==
      <<-javascript
<script type="text/javascript" charset="utf­8">
  var pageOptions = {"pubId":"pub","query":"emprego sorocaba"};

  var adblock1 = {"container":"adblock1","number":7,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  new google.ads.search.Ads(pageOptions, adblock1);
</script>
      javascript
  end

  it 'should respond to "title" helper' do
    @view.adsense_for_search('emprego sorocaba', :adblock1 => {:number => 5}, :adblock2 => {:number => 8}).should ==
      <<-javascript
<script type="text/javascript" charset="utf­8">
  var pageOptions = {"pubId":"pub","query":"emprego sorocaba"};

  var adblock1 = {"container":"adblock1","number":5,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  var adblock2 = {"container":"adblock2","number":8,"width":"250px","lines":3,"fontFamily":"arial","fontSizeTitle":"12px","fontSizeDescription":"12px","fontSizeDomainLink":"12px"};

  new google.ads.search.Ads(pageOptions, adblock1, adblock2);
</script>
      javascript
  end
end

