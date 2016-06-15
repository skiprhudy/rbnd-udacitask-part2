require 'colorize'

# shared format methods
module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_type(type)
    "#{type}".ljust(12)
  end

  # this could get ugly, and i don't think sharing 'format_date'
  # between classes that have potentially very different
  # date requirements is a good idea.
  def format_date(options = {})
    if options[:due]
      due = options[:due]
      return due ? due.strftime('%D') : 'No due date'
    end

    # completely different requirement than for todo class,
    # so why is it shared?
    start_date = options[:start_date] if options[:start_date]
    dates = start_date.strftime('%D') if start_date
    end_date = options[:end_date] if options[:end_date]
    dates << ' -- ' + end_date.strftime('%D') if end_date
    dates = 'N/A' if !dates
    return dates
  end

  def format_priority
    value = ' ⇧'.colorize(:red) if @priority == 'high'
    value = ' ⇨'.colorize(:yellow) if @priority == 'medium'
    value = ' ⇩'.colorize(:green) if @priority == 'low'
    value = '' if !@priority
    return value
  end
end

