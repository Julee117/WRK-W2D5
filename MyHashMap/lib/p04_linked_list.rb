require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def each(&block)

  end
  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    # debugger
    self.each do |el|
      return el.val if key == el.key
    end
  end

  def include?(key)
    self.each do |el|
      return true if key == el.key
    end
    false
  end

  def append(key, val)

    @tail.prev.next = Node.new(key, val)
    @tail.prev.next.next = @tail
    @tail.prev.next.prev = @tail.prev

    @tail.prev = @tail.prev.next

  end

  def update(key, val)
    self.each do |el|
      if el.key ==  key
        el.val = val
      end
    end
  end

  def remove(key)
    node = nil
    self.each do |el|
      node = el if el.key == key
    end

    node.prev.next = node.next
    node.next.prev = node.prev
    node.next = nil
    node.prev = nil
  end

  def each(&prc)
    x = first
    until x == @tail
      prc.call(x)
      x = x.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
