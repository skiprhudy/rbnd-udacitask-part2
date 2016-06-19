# all the special errors go here
module UdaciListErrors
  # Error classes go here
  class InvalidItemType < StandardError
    def initialize(type)
      super()
      @item = type
    end

    def message
      "Item type '#{@item}' not supported. Use 'todo','event','link', or 'image'."
    end
  end

  class IndexExceedsListSize < StandardError
  end

  class InvalidPriorityValue < StandardError
    def initialize(priority)
      @priority = priority
    end

    def message
      "Priority '#{@priority}' is not supported. Use 'low', 'medium', or 'high'."
    end
  end
end
