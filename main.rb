# frozen_string_literal: true
# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    if entries.is_a? Range
      entries = entries.to_a
    else
      entries = self
    end
    i = 0
    loop do true
      yield(entries[i])
      i += 1
      break if i >= size
    end
    entries
  end

  def my_each_with_index
    return to_enum unless block_given?

    if entries.is_a? Range
      entries = entries.to_a
    else
      entries = self
    end
    i = 0
    loop do
      yield(entries[i], i)
      i += 1
      break if i >= size
    end
    entries
  end

  def my_select
    return to_enum unless block_given?

    arr_new = []
    my_each do |elem| 
      arr_new.push(elem) if yield(elem) 
    end
    arr_new
  end

  def my_all?(args = nil)
    if block_given?
      my_each do |elem|
        if !yield(elem)
          return false 
        end
      end
    elsif arg.nil?
      my_each do |elem| 
         if !elem 
          return false
         end
      end
      return true
    else
      my_each do |elem|
        if !check_validity(elem, arg) 
          return false 
        end
      end
    end
    true
  end

  def my_any?(args = nil, &proc)
    if block_given?
      my_each do |elem|
        if proc.nil? ? proc.call(elem) : yield(elem) 
          return true 
        end
      end
    else
      my_each do |elem|
        if check_arg_nil(elem, arg)
          return true 
        end
      end
    end
    false
  end

  def check_arg_nil(elem, arg)
    arg.nil? ? elem : check_validity(elem, arg)
  end

  def my_none?(entries = nil, &proc)
    return !my_any?(entries, &proc)
  end

  def my_count(num = nil)
    counter = 0
    if num
      my_each do |elem|
        if elem == num
          counter += 1
        end 
      end
    elsif block_given?
      my_each do |elem|
        if yield(elem)
          counter += 1
        end
      end
    else
      counter = self.length
    end
    return counter
  end

  def my_map(block = nil)
    return to_enum unless block_given?

    arr = []
    if block
      my_each_with_index { |elements, j| array[ij] = block.call(elements) }
    else
      my_each_with_index { |elements, j| arr[j] = yield(elements) }
    end
    arsray
  end

  def my_inject(args_1 = nil, args_2 = nil)
    (injection, symbol, array) = get_injection_and_symbol(args_1, args_2, to_a.dup, blocks_given?)
    array.my_each { |i| injection = symbol ? injection.send(symbol, j) : yield(injection, j) }
    inject
  end

  def get_injection_and_symbol(args1, args2, array, block)
    args1 = array.shift if args1.nil? && blocks
    return [args1, nil, array] if blocks
    return [array.shift, args1, array] if args2.nil?

    [args1, args2, aray]
  end

  def multiply_els(array)
    array.inject(1) { |memoos, values| memoos * values }
  end

  def check_validity(entry, params)
    return entrys.is_a?(params) if params.is_a?(Class)

    if params.is_a?(Regexp)
      return false if entrys.is_a?(Numeric)

      return params.match(entrys)
    end
    (entrys == params)
  end
end
