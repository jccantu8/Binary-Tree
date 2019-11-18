class Node
    attr_accessor :leftChild, :rightChild, :parent, :value
  
    def initialize(value, parent = nil)
      @value = value
      @parent = parent
      @leftChild  = nil
      @rightChild  = nil
    end
  
  end
  
  class Tree
    attr_accessor :root
  
    def initialize(origArr)
      @root = nil
  
      build_array(origArr)
    end
  
    def build_array(origArr)
  
    origArr = origArr.uniq
  
    @root = Node.new(origArr[0])
  
      for i in (1...origArr.length)
        tmp = @root
        newNode = Node.new(origArr[i])
  
        flag = false
  
        until flag == true
          if (newNode.value < tmp.value)
              if tmp.leftChild.nil?
                tmp.leftChild = newNode
                newNode.parent = tmp
                flag = true
              else
                tmp = tmp.leftChild
                flag = false
              end
          else
              if tmp.rightChild.nil?
                tmp.rightChild = newNode
                newNode.parent = tmp
                flag = true
              else
                tmp = tmp.rightChild
                flag = false
              end
          end
        end
  
      end
  
      @root
  
    end
  
    def insert(value)
      tmp = @root
      newNode = Node.new(value)
  
      flag = false
  
      until flag == true
        if (value == tmp.value)
            raise "Value already exists. No duplicates allowed."
        elsif (value < tmp.value)
            if tmp.leftChild.nil?
              tmp.leftChild = newNode
              newNode.parent = tmp
              flag = true
            else
              tmp = tmp.leftChild
          end
        else
          if tmp.rightChild.nil?
            tmp.rightChild = newNode
            newNode.parent = tmp
            flag = true
          else
            tmp = tmp.rightChild
          end
        end
      end
  
      @root
    end
  
    def delete(value)
      tmp = @root
  
      flag = false
  
      until flag == true
        if (value == tmp.value)
          if (tmp.leftChild.nil? and tmp.rightChild.nil?)
            if (tmp.parent.leftChild == tmp)
              tmp.parent.leftChild = nil
            else
              tmp.parent.rightChild = nil
            end
          elsif (!tmp.leftChild.nil? and tmp.rightChild.nil?)
            if (tmp.parent.leftChild == tmp)
              tmp.parent.leftChild = tmp.leftChild
              tmp.leftChild.parent = tmp.parent
            else
              tmp.parent.rightChild = tmp.leftChild
              tmp.leftChild.parent = tmp.parent
            end
          elsif (tmp.leftChild.nil? and !tmp.rightChild.nil?)
            if (tmp.parent.leftChild == tmp)
              tmp.parent.leftChild = tmp.rightChild
              tmp.rightChild.parent = tmp.parent
            else
              tmp.parent.rightChild = tmp.rightChild
              tmp.rightChild.parent = tmp.parent
            end
          else #(tmp.leftChild != nil and tmp.rightChild != nil)
          puts 4
            replacement = tmp.rightChild
  
            until (replacement.leftChild == nil)
              replacement = replacement.leftChild
            end
  
            if (replacement.rightChild != nil)
              replacement.rightChild.parent = replacement.parent
              replacement.parent.leftChild = replacement.rightChild
  
              replacement.rightChild = tmp.rightChild
              replacement.leftChild = tmp.leftChild
              replacement.parent = tmp.parent
              tmp = replacement
            else
              replacement.parent.leftChild = nil
  
              replacement.rightChild = tmp.rightChild
              replacement.leftChild = tmp.leftChild
              replacement.parent = tmp.parent
              tmp = replacement
            end
          end
  
          flag = true
        elsif (value < tmp.value)
          if tmp.leftChild.nil?
            raise "Value does not exist."
            flag = true
          else
            tmp = tmp.leftChild
          end
        else
          if tmp.rightChild.nil?
            raise "Value does not exist."
            flag = true
          else
            tmp = tmp.rightChild
          end
        end
      end
  
      @root
    end
   
    def find(value)
      tmp = @root
  
      flag = false
  
      until flag == true
        if (value == tmp.value)
          flag = true
        elsif (value < tmp.value)
          if tmp.leftChild.nil?
            raise "Value does not exist."
            flag = true
          else
            tmp = tmp.leftChild
          end
        else
          if tmp.rightChild.nil?
            raise "Value does not exist."
            flag = true
          else
            tmp = tmp.rightChild
          end
        end
      end
  
      tmp
    end
  
    def preorder(node  = @root, valueArr = [], &block)
      if (node.nil?)
        return valueArr
      end
  
      if block_given?
        yield
      else
        valueArr.push(node.value)
      end
  
      preorder(node.leftChild, valueArr, &block)
      preorder(node.rightChild, valueArr, &block)
  
    end
  
    def inorder(node  = @root, valueArr = [], &block)
      if (node.nil?)
        return valueArr
      end
  
      inorder(node.leftChild, valueArr, &block)
  
      if block_given?
        yield
      else
        valueArr.push(node.value)
      end
  
      inorder(node.rightChild, valueArr, &block)
  
    end
  
    def postorder(node  = @root, valueArr = [], &block)
      if (node.nil?)
        return valueArr
      end
  
      postorder(node.leftChild, valueArr, &block)
      postorder(node.rightChild, valueArr, &block)
  
      if block_given?
        yield
      else
        valueArr.push(node.value)
      end
  
    end
  
    def depth(node = @root)
      if (node.nil?)
        return 0
      else
        max1 = depth(node.leftChild)
        max2 = depth(node.rightChild)
        max = [max1, max2].max + 1
        return max
      end
    end
  
    def level_order(node = @root, &block)
      if (node.nil?)
        return
      end
  
      valueArr = []
      queue = []
  
      queue.push(node)
  
      while (!queue.empty?)
        current = queue.first
  
        if block_given?
          yield
        else
          valueArr.push(current.value)
        end
  
        if (!current.leftChild.nil?)
          queue.push(current.leftChild)
        end
  
        if (!current.rightChild.nil?)
          queue.push(current.rightChild)
        end
  
        queue.shift
      end
  
      valueArr
    end
  
    def balanced?(node = @root)
      if (node.nil?)
        return true
      end
        leftHeight = depth(node.leftChild)
        rightHeight = depth(node.rightChild)
        if ((leftHeight - rightHeight).abs <= 1) and balanced?(node.leftChild) and balanced?(node.rightChild)
          return true
        else
          return false
        end
    end
  
    def rebalance!(node = @root)
      if (balanced?(node))
        return "Already balanced."
      else
        sortedArr = level_order(node).sort()
  
        @root = sortedToBalanced(sortedArr)
        balanced?(@root)
      end
    end
  
    def sortedToBalanced(arr, parent = nil)
      if (arr.length == 1)
        return Node.new(arr[0], parent)
      else
        middle  = (arr.length / 2)
  
        root = Node.new(arr[middle], parent)
  
        root.leftChild = sortedToBalanced(arr[0...middle], root)
        root.rightChild = sortedToBalanced(arr[middle..arr.length], root)
  
        return root
      end
    end
  end
  
  testArr = Array.new(15) { rand(1..100) }
  myTree = Tree.new(testArr)
  
  #Check if tree is balanced
  puts myTree.balanced?().inspect
  
  #Elements in level order
  puts myTree.level_order().inspect
  
  #Elements in pre order
  puts myTree.preorder().inspect
  
  #Elements in post order
  puts myTree.postorder().inspect
  
  #Elements in inorder
  puts myTree.inorder().inspect
  
  #Attempt to unbalance tree by adding random large numbers
  5.times {myTree.insert(rand(101..150))}
  
  puts myTree.balanced?().inspect
  
  #Balance the tree
  myTree.rebalance!()
  
  puts myTree.balanced?().inspect
  