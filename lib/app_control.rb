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

  # HighLine doesn't yet support adding items to menu programmatically (well, it
  # does on 'master' branch, but master isn't what gets installed with gem install
  # or bundle install, right now is limited to 1.7.8 ... no adding items til new master
  # is released. so this is lame ... can update with new functionality in HighLine
  # is released)
  def delete_items
    puts
    @list.all
    puts
    puts "Enter item to delete:"
    number = STDIN.getc
    STDIN.flush
    @list.delete(number.to_i)
    puts
    @list.all
  end

end