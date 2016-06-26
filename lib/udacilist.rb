require_relative 'constants'

# implements the functionality for lists
class UdaciList

  attr_reader :title, :items

  def initialize(options = {})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    Item::check_type(type) # guard clause for invalid types
    Item::check_priority(options[:priority]) if options[:priority]
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
    list_item_array(@items)
    puts
  end

  def item_descriptions
    descs = []
    @items.each do |item|
      descs << item.description
    end
    descs
  end

  def filter(type)
    @title = "Filtered By Type: #{type.capitalize}"
    puts '-' * @title.length
    puts @title
    puts '-' * @title.length
    class_name = Item::get_type(type)
    type_ary = @items.select{ |item| item.class.name == class_name }
    list_item_array(type_ary)
  end

  def item_priority(priority, idx)
    if idx < 0
      raise UdaciListErrors::IndexUnderflowListSize
    end
    @items[idx].new_priority(priority)
  end

  private

  def list_item_array(ary)
    ary.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

end
