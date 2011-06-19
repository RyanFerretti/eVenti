require "spec_helper"

describe AdsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ads" }.should route_to(:controller => "ads", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ads/new" }.should route_to(:controller => "ads", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ads/1" }.should route_to(:controller => "ads", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ads/1/edit" }.should route_to(:controller => "ads", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ads" }.should route_to(:controller => "ads", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ads/1" }.should route_to(:controller => "ads", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ads/1" }.should route_to(:controller => "ads", :action => "destroy", :id => "1")
    end

  end
end
