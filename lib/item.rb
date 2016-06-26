require_relative 'listable'

module Constants
  VALID_TYPES = {
    todo: 'todo',
    event: 'event',
    link: 'link'
  }.freeze
  VALID_PRIORITY = {
    low: 'low',
    medium: 'medium',
    high: 'high'
  }.freeze
end

# base item
class Item
  include Constants
  include Listable

  attr_reader :description, :priority

  def self.get_type(type)
    check_type(type)
    case type
    when 'todo'
      return 'TodoItem'
    when 'event'
      return 'EventItem'
    when 'link'
      return 'LinkItem'
    end
  end

  def self.check_type(type)
    return if VALID_TYPES.value? type
    raise UdaciListErrors::InvalidItemType.new(type)
  end

  def self.check_priority(priority)
    return if VALID_PRIORITY.value? priority
    raise UdaciListErrors::InvalidPriorityValue.new(priority)
  end

  def initialize(description)
    @description = description
  end

  def new_priority(priority)
    raise UdaciListErrors::InvalidPriorityValue.new(priority) unless VALID_PRIORITY.value? priority
    @priority = priority
  end


end