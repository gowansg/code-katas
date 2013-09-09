module Enumerable
  #returns the value of the element at the start of a repeating series
  def dups_in_a_row?(num_of_repeats)
    each_index do |i|
      return nil if i + num_of_repeats > self.length
      return self[i] if self[i...(i + num_of_repeats)].all? { |v| v == self[i] }
    end
  end

  #determines whether or not a given sequence is sequential
  def sequential?(start = 0, stop = length)
  	range = drop(start).take(stop)
    range.each_index do |i|
  		return true if i == range.length - 1
      return false unless (range[i] - range[i + 1]).abs == 1
  	end
  end
end