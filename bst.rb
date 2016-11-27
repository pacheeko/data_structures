class Node

  attr_accessor :value, :parent, :left, :right

  def initialize
  	@value = nil
  	@parent = nil
  	@left = nil
  	@right = nil
  end
end
  
def build_tree_sorted(array)
  case array.length
  when 0
    return
  when 1
    node = Node.new
    node.value = array[0]
    return node
  when 2
  	node = Node.new
  	node.value = array[1]
    node.left = build_tree_sorted([array[0]])
    node.left.parent = node
  else
    index = array.length/2
    node = Node.new
    node.value = array[index]
    node.left = build_tree_sorted(array[0,index])
    node.right = build_tree_sorted(array[index+1,array.length])
    node.left.parent = node
    node.right.parent = node
  end
end

def build_tree(array,root=nil)
  unless array.empty?
    node = Node.new
    node.value = array[0]
    if root == nil
      root = node
      build_tree(array[1,array.length],root)
    else
      node2 = root
      loop do
        if node.value < node2.value
          if node2.left == nil
          	node2.left = node
          	break
          else
      	    node2 = node2.left
      	  end
      	else
      	  if node2.right == nil
      	  	node2.right = node
      	  	break
      	  else
      	    node2 = node2.right
      	  end
      	end
      end
      node.parent = node2
      build_tree(array[1,array.length],root)
    end
  end
  return root
end


def print_tree(node)	
  str = "Value: #{node.value}. "
  unless node.parent == nil
  	str += "Parent: #{node.parent.value}."
  end
  puts str
  print_tree(node.left) unless node.left == nil
  print_tree(node.right) unless node.right == nil
end

def breadth_first_search(tree,value)
  node = tree
  unless node == nil
  	queue = [node]
  	loop do
  	  if node.value == value
  	  	break
  	  elsif queue.empty?
  	  	node = nil
  	  	break
  	  else
  	  	node = queue.shift
  	    queue << node.left unless node.left == nil
  	    queue << node.right unless node.right == nil
  	  end
  	end
  end
  return node
end	

def depth_first_search(tree,value)
  node = tree
  unless node == nil
  	stack = [node]
  	loop do
  	  if node.value == value
  	  	break
  	  elsif stack.empty?
  	  	node = nil
  	  	break
  	  else
  	  	node = stack.shift
  	    stack.unshift(node.right) unless node.right == nil
  	    stack.unshift(node.left) unless node.left == nil
  	  end
  	end
  end
  return node
end	

def dfs_rec(node,value)
  if node == nil
  	nil
  elsif node.value == value
  	return node
  else
  	node1 = dfs_rec(node.left,value) 
  	node2 = dfs_rec(node.right,value)
  	if node1 
  	  return node1
  	elsif node2
  	  return node2
  	else
  	  return nil
  	end 
  end
end

new_tree = build_tree([13,2,8,10,7,1,14,6,4])
print_tree(new_tree)


