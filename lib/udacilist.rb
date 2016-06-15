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


# implements the functionality for lists
class UdaciList

  attr_reader :title, :items

  include Constants

  def initialize(options = {})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    check_type type
    check_priority options[:priority] if options[:priority]
    @items.push TodoItem.new(description, options) if type == 'todo'
    @items.push EventItem.new(description, options) if type == 'event'
    @items.push LinkItem.new(description, options) if type == 'link'
  end

  def delete(index)
    remove_idx = index - 1
    raise UdaciListErrors::IndexExceedsListSize if remove_idx >= @items.length
    @items.delete_at(index - 1)
  end

  def all
    @title = 'Untitled List' if @title.nil? || @title.empty?
    puts '-' * @title.length
    puts @title
    puts '-' * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  private

  def check_type(type)
    return if VALID_TYPES.value? type
    raise UdaciListErrors::InvalidItemType
  end

  def check_priority(priority)
    return if VALID_PRIORITY.value? priority
    raise UdaciListErrors::InvalidPriorityValue
  end
end
