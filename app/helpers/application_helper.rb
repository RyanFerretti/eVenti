module ApplicationHelper
  def body_class
    "admin" if current_admin
  end

  def build_vote_links(member)
    links = ""
    1.upto(10) do |i|
      links << link_to("#{i}", vote_for_path(:member_id => @members.first.id, :vote_value => i), :remote => true, :method => :post, :class => "vote_link")
      links << " "
    end
    raw links
  end

  def build_relationship_options
    ["Single","In a relationship","Engaged","Married","It's complicated","In an open relationship","Widowed","Separated","Divorced","In a civil union","In a domestic partnership"]
  end

  def build_bust_options
    build_options_with_range(30..40)
  end

  def build_waist_options
    build_options_with_range(20..30)
  end

  def build_hips_options
    build_options_with_range(30..40)
  end

  def build_options_with_range(range)
    options = []
    range.step(2) {|i| options << i }
    options
  end
end
