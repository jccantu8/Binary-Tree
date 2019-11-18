# Binary-Tree

A binary search tree with the following actions:
	
#build_array
  Creates a binary tree where no duplicates are allowed.

#insert(value)
  Inserts a new node with value into the tree.

#delete(value)
  Deletes the value, if found, from the tree.

#find(value)
  Returns node with value, if found.

#level_order(node = @root, &block)
  Traverses the tree breadth wise and performs code given in block on each node. If no block is given, will display return an array of values.

#preorder(node  = @root, valueArr = [], &block)
  Traverses the tree preorder wise and performs code given in block on each node. If no block is given, will display return an array of values.

#inorder(node  = @root, valueArr = [], &block)
  Traverses the tree inorder wise and performs code given in block on each node. If no block is given, will display return an array of values.

#postorder(node  = @root, valueArr = [], &block)
  Traverses the tree postorder wise and performs code given in block on each node. If no block is given, will display return an array of values.

#depth(node = @root)
  Returns the height of provided root.

#balanced?(node = @root)
  Return true if tree is balanced and false otherwise.

#rebalance!(node = @root)
  Rebalances tree if unbalanced by first converting a level_order array of the original tree to a sorted array. Then uses #sortedToBalance as a recursive helper function to splitting the sorted array into halves.

#def sortedToBalanced(arr, parent = nil)
  Helper function for #rebalance!
