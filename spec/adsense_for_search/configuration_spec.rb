# encoding: utf-8

require 'spec_helper'

describe AdSenseForSearch do    
  before do
    @path = '/Users/tiago/Sites/adsense_for_search'
    @file = "#{@path}/config/adsense_for_search.yml"
  end
  
  context 'config_file' do
    before(:each) do
      AdSenseForSearch.config_file = nil
    end
    
    it '' do
      AdSenseForSearch.config_file = @file
      AdSenseForSearch.config_file.should eq(@file)
    end
    
    it '' do
      Rails.stub(:root => @path)
      
      AdSenseForSearch.config_file.should == @file
    end
  end
  
 context '' do
    before do
      @attributes           = { :adblock1 => { :number => 3 } }
      @different_attributes = { :adblock2 => { :number => 7 } }
    end
    
    it '' do
      AdSenseForSearch.stub(:config_file => @file)
      
      YAML.should_receive(:load_file).with(@file).and_return(:default => @attributes)
      AdSenseForSearch.config.should == @attributes
    end
    
    it '' do
      AdSenseForSearch.config_file = nil
      
      YAML.should_receive(:load_file).with(AdSenseForSearch.default_config_file).and_return(:default => @different_attributes)
      
      AdSenseForSearch.config.should == @different_attributes
    end
  end
end
  