require 'highline'

class AppControl
  def initialize(cli, list = nil)
    @cli = cli
    @list = list
    @exit = false
  end

  def exit?
    @exit
  end

  def handle_exit
    @exit = true
    return
  end

  def add_items
    puts
    @cli.choose do |menu|
      menu.choice('Todo Item') { add_todo }
      menu.choice('Event Item') { add_event }
      menu.choice('Link Item') { add_link }
      menu.choice('Go back') { return }
      menu.prompt = 'Pick what kind of item to add from above:'
    end
  end

  def list_items
    puts
    @cli.choose do |menu|
      menu.choice('All Items') { @list.all }
      menu.choice('By Item Type') { list_by_type }
      menu.choice('Go back') { return }
      menu.prompt = 'Pick how you want to list items from above:'
    end
    puts
  end

  def delete_items
    puts
    @cli.choose do |menu|
      @list.all.each_with_index do |item, idx |
        menu.choice(item.description) { @list.delete(idx + 1)}
      end
      menu.choice('Go back') { return }
      menu.prompt = 'Choose item to delete from above:'
    end
    puts
  end

  private

  def list_by_type
    puts
    @cli.choose do |menu|
      menu.choice('Event') { @list.filter 'event' }
      menu.choice('Todo') { @list.filter 'todo' }
      menu.choice('Link') { @list.filter 'link' }
      menu.choice('Go back') { return }
      menu.prompt = 'Choose type from above:'
    end
    puts
  end

  # i can avoid 'return if desc.nil?' code by raising
  # an error in the description method and other methods
  # like it, and handling that in the code that calls add_todo
  # add_event, and add_link
  def add_todo
    puts
    desc = description
    return if desc.nil?
    due = due_date
    priority = item_priority
    @list.add('todo',desc, { due: due, priority: priority})
    puts
  end

  def add_event
    puts
    desc = description
    return if desc.nil?
    start_date = starting_date
    return if start_date.nil?
    end_date = ending_date
    return if end_date.nil?
    @list.add('event', desc, { start_date: start_date, end_date: end_date})
    puts
  end

  def add_link
    puts
    desc = description
    return if desc.nil?
    site = site_name
    @list.add('link', desc, { site_name: site })
    puts
  end

  def description
    desc = @cli.ask('Todo description (required):')
    if desc.empty?
      puts 'Sorry a non-empty description is required'
      return
    end
    desc
  end

  def due_date
    due = @cli.ask('Due date (optional):')
    due = nil if due.empty?
    due
  end

  def item_priority
    priority = @cli.ask('Priority low, medium, high (optional):')
    if priority.empty?
      return nil
    else
      unless VALID_PRIORITY.has_value?(priority)
        puts 'Sorry that is not low, medium, or high priority'
        return nil
      end
    end
    priority
  end

  def starting_date
    start_date = @cli.ask('What is the start date? (required)')
    if start_date.empty?
      puts 'Sorry a valid start date is required.'
      return nil
    end
    start_date
  end

  def ending_date
    end_date = @cli.ask('What is the end date? (required:')
    if end_date.empty?
      puts 'Sorry a valid end date is required.'
      return nil
    end
    end_date
  end

  def site_name
    site = @cli.ask('What is the site name? (optional)')
    site = nil if site.empty?
    site
  end
end