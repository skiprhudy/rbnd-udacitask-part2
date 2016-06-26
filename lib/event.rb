require_relative 'item'

# an event item
class EventItem < Item
  include Listable
  attr_reader :start_date, :end_date

  def initialize(description, options = {})
    super(description)
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
    @priority = options[:priority] if options[:priority]
  end

  def details
    format_description(@description) + "Type: " +
        format_type("EventItem")  + 'event dates: ' +
        format_date({start_date: @start_date, end_data: @end_date})
  end
end
