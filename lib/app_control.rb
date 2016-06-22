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

  end

  def list_items
    puts
    @cli.choose do |menu|
      menu.prompt = 'Pick how you want to list items from above:'
      menu.choice('All Items') { @list.all }
      menu.choice('By Item Type') { list_by_type }
      menu.choice('Go back') { return }
    end
    puts
  end

  def list_by_type
    puts
    @cli.choose do |menu|
      menu.prompt = 'Choose type from above:'
      menu.choice('Event') { @list.filter 'event' }
      menu.choice('Todo') { @list.filter 'todo' }
      menu.choice('Link') { @list.filter 'link' }
      menu.choice('Go back') { return }
    end
    puts
  end

  def delete_items
    puts
    answer = @cli.choose do |menu|
      @list.all.each_with_index do |item, idx |
        menu.choice(item.description) { @list.delete(idx + 1)}
      end
      menu.prompt = 'Choose item to delete from above:'
    end
    puts
  end
end