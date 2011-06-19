require 'spec_helper'

describe "ads/show.html.haml" do
  before(:each) do
    @ad = assign(:ad, stub_model(Ad,
      :contents => "MyText",
      :ad_group_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
