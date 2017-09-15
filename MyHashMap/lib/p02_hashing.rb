class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = ""
    result += self.length.to_s
    self.each do |num|
      result += num.to_s
    end
    result.to_i
  end
end

class String
  def hash
    result = ""
    result += self.length.to_s
    self.split("").each do |el|
      result += el.ord.to_s
    end
    result.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = ""
    result += self.length.to_s
    self.keys.sort.each do |k|
      result += k.to_s.ord.to_s
    end
    result.to_i
  end
end
