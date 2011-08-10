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

  def build_vote_link(member,i)
    link_to("#{i}", vote_for_path(:member_id => member.id, :vote_value => i), :remote => true, :method => :post, :class => "vote_link")
  end

  def build_relationship_options
    ["Single","In a relationship","Engaged","Married","It's complicated","In an open relationship","Widowed","Separated","Divorced","In a civil union","In a domestic partnership"]
  end

  def build_bust_options
    build_options_with_range(30..40)
  end

  def build_waist_options
    build_options_with_range(22..40)
  end

  def build_hips_options
    build_options_with_range(30..50)
  end

  def build_options_with_range(range)
    options = []
    range.step(2) {|i| options << i }
    options
  end

  def build_rating_filter_options
    options = [["Descending","descending"],["Ascending","ascending"]]
    10.downto(1) do |i|
      options << [i,i]
    end
    options
  end

  def build_level_filter_options
    [["Semi Finalist",1],["Local Finalist",2],["National Finalist",3],["Miss Uproar 2011",4]]
  end

  def build_city_filter_options(locations)
    options = []
    locations.each do |location|
      options << [location.name,location.id]
    end
    options
  end

  # overriding default devise helper
  def error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join

    html = <<-HTML
    <div class="alert">
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  # could expand this to include defaults passed in then do a merge! on options
  def ssl_options(options = {})
    {:protocol => "https", :only_path => false} unless Rails.env.development?
  end

  def build_states_list
    Carmen::states('US').concat(Carmen::states('CA'))
  end

  def location_drop_down_options
    options = [["Select a City", ""]]
    Location.active.collect {|l| options << [ "#{l.city}, #{l.state}", l.to_param ] }
    options
  end
end
