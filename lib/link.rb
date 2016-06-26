require_relative 'item'

# a link to something cool
class LinkItem < Item
  include Listable
  attr_reader :site_name

  def initialize(url, options = {})
    super(url)
    @site_name = options[:site_name]
  end

  def format_name
    @site_name ? @site_name : 'Not specified'
  end

  def details
    format_description(@description) + "Type: " +
        format_type("LinkItem") + 'site name: ' + format_name
  end
end
