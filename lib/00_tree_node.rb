



class PolyTreeNode
  # include Searchable

  attr_accessor :value
  attr_reader :parent, :value

  def initialize(value = nil)
    @value, @parent, @children = value, nil, []
  end



  def dfs(target_value)
    return self if value == target_value
    self._children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result.nil? # NB .nil part
    end
    nil
  end

  def bfs(target_value)
    arr = []
    arr << self
    until arr == []
      arr.each do |node|
        if node.value == target_value
          return node
        else
          arr.shift
          node._children.each {|child| arr.push(child)}
        end
      end
    end
  end

  def children
    # We dup to avoid someone inadvertently trying to modify our
    # children directly through the children array. Note that
    # `parent=` works hard to make sure children/parent always match
    # up. We don't trust our users to do this.
    @children.dup
  end

  def parent=(parent)
    return if self.parent == parent

    # First, detach from current parent.
    if self.parent
      self.parent._children.delete(self)
    end

    # No new parent to add this to.
    @parent = parent
    self.parent._children << self unless self.parent.nil?

    self
  end

  def add_child(child)
    # Just reset the child's parent to us!
    child.parent = self
  end

  def remove_child(child)
    # Thanks for doing all the work, `parent=`!
    if child && !self.children.include?(child)
      raise "Tried to remove node that isn't a child"
    end

    child.parent = nil
  end

  # protected

  # Protected method to give a node direct access to another node's
  # children.
  def _children
    @children
  end
end







# class PolyTreeNode
#
#   attr_reader :value, :parent, :children
#   def initialize(value)
#     @value = value
#     @parent = nil
#     @children = []
#   end
#
#
#   def parent=(value)
#
#     return if self.parent == parent
#
#     # First, detach from current parent.
#     if self.parent
#       self.parent._children.delete(self)
#     end
#
#     # No new parent to add this to.
#     @parent = parent
#     self.parent._children << self unless self.parent.nil?
#
#     self
#     # @parent = value
#     # value.add_child(self)
#   end
#
#   def add_child(value)
#     parent=
#     @children << value
#   end
#
#   def remove_child
#     # @children[-1].parent=(nil)
#   end
#
#
# end
