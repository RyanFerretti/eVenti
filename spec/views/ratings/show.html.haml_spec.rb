require 'spec_helper'

describe "ratings/show.html.haml" do
  before(:each) do
    @rating = assign(:rating, stub_model(Rating,
      :member_id => "Member",
      :value => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Member/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
