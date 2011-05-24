require 'spec_helper'

describe "locations/show.html.haml" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :city => "City",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
  end
end
