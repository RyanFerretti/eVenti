require 'spec_helper'

describe "ratings/index.html.haml" do
  before(:each) do
    assign(:ratings, [
      stub_model(Rating,
        :member_id => "Member",
        :value => 1
      ),
      stub_model(Rating,
        :member_id => "Member",
        :value => 1
      )
    ])
  end

  it "renders a list of ratings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Member".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
