require 'bundler/setup'
require 'chronic'
require 'colorize'


# Find a third gem of your choice and add it to your project
require 'date'
require_relative 'lib/listable'
require_relative 'lib/errors'
require_relative 'lib/udacilist'
require_relative 'lib/todo'
require_relative 'lib/event'
require_relative 'lib/link'
require_relative 'lib/app_control'

# utility
def put_error(error)
  puts error
end

list = UdaciList.new(title: "Julia's Stuff")
list.add('todo', 'Buy more cat food', due: '2016-02-03', priority: 'low')
list.add('todo', 'Sweep floors', due: '2016-01-30')
list.add('todo', 'Buy groceries', priority: 'high')
list.add('event', 'Birthday Party', start_date: '2016-05-08')
list.add('event', 'Vacation', start_date: '2016-05-28', end_date: '2016-05-31')
list.add('link', 'https://github.com', site_name: 'GitHub Homepage')
list.all
list.delete(3)
list.all

# SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
# --------------------------------------------------
new_list = UdaciList.new # Should create a list called "Untitled List"
new_list.add('todo', 'Buy more dog food', due: 'in 5 weeks', priority: 'medium')
new_list.add('todo', 'Go dancing', due: 'in 2 hours')
new_list.add('todo', 'Buy groceries', priority: 'high')
new_list.add('event', 'Birthday Party', start_date: 'May 31')
new_list.add('event', 'Vacation', start_date: 'Dec 20', end_date: 'Dec 30')
new_list.add('event', 'Life happens')
new_list.add('link', 'https://www.udacity.com/', site_name: 'Udacity Homepage')
new_list.add('link', 'http://ruby-doc.org')

# SHOULD RETURN ERROR MESSAGES
# ----------------------------
# Throws InvalidItemType error
# rescue clauses are so i don't have to comment out
puts
begin
  new_list.add('image', 'http://ruby-doc.org')
rescue UdaciListErrors::InvalidItemType => iit
  put_error(iit.message)
end

# Throws an IndexExceedsListSize error
begin
  new_list.delete(9)
rescue UdaciListErrors::IndexExceedsListSize => iels
  put_error(iels.message)
end

# throws an InvalidPriorityValue error
begin
  new_list.add('todo', 'Hack some portals', priority: 'super high')
rescue UdaciListErrors::InvalidPriorityValue => ipv
  put_error(ipv.message)
end
puts

# DISPLAY UNTITLED LIST
# ---------------------
new_list.all

# DEMO FILTER BY ITEM TYPE
# ------------------------
new_list.filter('event')

# error -- invalid item type
begin
  new_list.add('motogpbike', 'ride asap')
rescue UdaciListErrors::InvalidItemType => iit
  puts
  puts iit.message
end

# now let's so something more interesting
exit = false
cli = HighLine.new
app_ctrl = AppControl.new(cli,list)
while app_ctrl.exit? != true
  puts
  cli.choose do |menu|
    menu.choice("Add Items") { app_ctrl.add_items }
    menu.choice("List Items") { app_ctrl.list_items }
    menu.choice("Delete Items") { app_ctrl.delete_items }
    menu.choice('Change Priority') { app_ctrl.change_priority }
    menu.choice("Exit") { app_ctrl.handle_exit }
    menu.prompt = "Pick one of the choices listed above (by text or number):"
  end
end








