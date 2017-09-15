require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(key_buckets = 8)
    @store = Array.new(key_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == key_buckets
    # key = key.hash
    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](key)
    @store[key.hash % key_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end

  def key_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(key_buckets * 2) {Array.new}
    @count = 0
    old_store.each do |bucket|
      bucket.each do |val|
        self.insert(val)
      end
    end
    @store
  end
end
