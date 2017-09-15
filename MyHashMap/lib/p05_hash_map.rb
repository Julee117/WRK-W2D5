require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    # debugger
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.each do |bucket|
      return true if bucket.include?(key)
    end
    false
  end

  def set(key, val)
    self.bucket(key).append(key, val)

    # @tail.prev.next = Node.new(key, val)
    # @tail.prev.next.next = @tail
    # @tail.prev.next.prev = @tail.prev
    # @tail.prev = @tail.prev.next
  end

  def get(key)
    @store.each do |el|
      return true if el.include?(key.hash)
    end
    false
  end

  def delete(key)
    @store.map do |array|
      array.delete(key) if array.include?(key)
    end


  end

  def each(&prc)
    result = []
    x = 0
    while x < self.length
      result << prc.call(x)
      x += 1
    end
    result
  end



  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) {LinkedList.new}
    @count = 0
    old_store.each do |bucket|
      bucket.each do |val|
        self.insert(val)
      end
    end
    @store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
