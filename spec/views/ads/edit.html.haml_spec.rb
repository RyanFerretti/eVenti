require 'spec_helper'

describe "ads/edit.html.haml" do
  before(:each) do
    @ad = assign(:ad, stub_model(Ad,
      :contents => "MyText",
      :ad_group_id => 1
    ))
  end

  it "renders the edit ad form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ads_path(@ad), :method => "post" do
      assert_select "textarea#ad_contents", :name => "ad[contents]"
      assert_select "input#ad_ad_group_id", :name => "ad[ad_group_id]"
    end
  end
end
