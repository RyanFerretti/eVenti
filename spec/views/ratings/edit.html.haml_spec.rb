require 'spec_helper'

describe "ratings/edit.html.haml" do
  before(:each) do
    @rating = assign(:rating, stub_model(Rating,
      :member_id => "MyString",
      :value => 1
    ))
  end

  it "renders the edit rating form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ratings_path(@rating), :method => "post" do
      assert_select "input#rating_member_id", :name => "rating[member_id]"
      assert_select "input#rating_value", :name => "rating[value]"
    end
  end
end
