# the todo item implementation
class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options = {})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end

  def details
    format_description(@description) + "Type: " +
        format_type("TodoItem") + 'due: ' +
        format_date({due: @due}) +
        format_priority
  end
end
