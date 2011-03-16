# encoding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

require "adsense_for_search"
require 'rails'

describe AdSenseForSearch do
  before :each do
    @view = ActionView::Base.new
    
    AdSenseForSearch.pubId = 'pub-123456789'
    AdSenseForSearch.channel = '123456789'
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
  var pageOptions = {"pubId":"pub-123456789","query":"emprego sorocaba","channel":"123456789","adtest":"on"};

  var adblock1 = {"container":"adblock1","number":7,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  new google.ads.search.Ads(pageOptions, adblock1);
</script>
      javascript
  end

  it 'should respond to "title" helper' do
    @view.adsense_for_search('emprego sorocaba', :adblock1 => {:number => 5}, :adblock2 => {:number => 8}).should ==
      <<-javascript
<script type="text/javascript" charset="utf­8">
  var pageOptions = {"pubId":"pub-123456789","query":"emprego sorocaba","channel":"123456789","adtest":"on"};

  var adblock1 = {"container":"adblock1","number":5,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  var adblock2 = {"container":"adblock2","number":8,"width":"250px","lines":3,"fontFamily":"arial","fontSizeTitle":"12px","fontSizeDescription":"12px","fontSizeDomainLink":"12px"};

  new google.ads.search.Ads(pageOptions, adblock1, adblock2);
</script>
      javascript
  end
  
  it 'should respond to "title" helper' do
    @view.adsense_for_search('imobiliária são paulo', :adblock1 => {:number => 7}).should ==
      <<-javascript
<script type="text/javascript" charset="utf­8">
  var pageOptions = {"pubId":"pub-123456789","query":"imobiliária são paulo","channel":"123456789","adtest":"on"};

  var adblock1 = {"container":"adblock1","number":7,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  new google.ads.search.Ads(pageOptions, adblock1);
</script>
      javascript
  end
  
  it '' do
    @view.adsense_for_search('imobiliária são paulo', :adblock1 => {:number => 7}, :options => {:pubId => 'pub-987654321', :channel => '987654321'}).should ==
      <<-javascript
<script type="text/javascript" charset="utf­8">
  var pageOptions = {"pubId":"pub-987654321","query":"imobiliária são paulo","channel":"987654321","adtest":"on"};

  var adblock1 = {"container":"adblock1","number":7,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  new google.ads.search.Ads(pageOptions, adblock1);
</script>
      javascript
  end
  
  it '' do
    @view.adsense_for_search('imobiliária são paulo', :adblock1 => {:number => 7}, :options => {:pubId => 'pub-987654321', :channel => '987654321', :linkTarget => '_blank'}).should ==
      <<-javascript
<script type="text/javascript" charset="utf­8">
  var pageOptions = {"pubId":"pub-987654321","query":"imobiliária são paulo","channel":"987654321","adtest":"on","linkTarget":"_blank"};

  var adblock1 = {"container":"adblock1","number":7,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  new google.ads.search.Ads(pageOptions, adblock1);
</script>
      javascript
  end
  
  it 'test environment' do
    Rails.stub!(:env).and_return('production')
    
    @view.adsense_for_search('emprego sorocaba', :adblock1 => {:number => 7}).should ==
      <<-javascript
<script type="text/javascript" charset="utf­8">
  var pageOptions = {"pubId":"pub-123456789","query":"emprego sorocaba","channel":"123456789"};

  var adblock1 = {"container":"adblock1","number":7,"width":"auto","lines":2,"fontFamily":"arial","fontSizeTitle":"14px","fontSizeDescription":"14px","fontSizeDomainLink":"14px"};

  new google.ads.search.Ads(pageOptions, adblock1);
</script>
      javascript
  end
end

describe Hash do
  it '' do
    {:city => 'São Paulo', :state => 'SP'}.to_json2.should == '{"city":"São Paulo","state":"SP"}'
  end
end
