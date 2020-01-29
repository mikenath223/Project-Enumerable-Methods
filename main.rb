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

  def my_all?(arg = nil)
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

  def my_any?(arg = nil, &proc)
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
      my_each_with_index { |elem, i| arr[i] = block.call(elem) }
    else
      my_each_with_index { |elem, i| arr[i] = yield(elem) }
    end
    arr
  end

  def my_inject(arg_1 = nil, arg_2 = nil)
    (inject, sym, array) = get_inject_and_sym(arg_1, arg_2, to_a.dup, block_given?)
    array.my_each { |i| inject = sym ? inject.send(sym, i) : yield(inject, i) }
    inject
  end

  def get_inject_and_sym(arg1, arg2, arr, block)
    arg1 = arr.shift if arg1.nil? && block
    return [arg1, nil, arr] if block
    return [arr.shift, arg1, arr] if arg2.nil?

    [arg1, arg2, arr]
  end

  def multiply_els(arr)
    arr.inject(1) { |memo, vals| memo * vals }
  end

  def check_validity(entry, param)
    return entry.is_a?(param) if param.is_a?(Class)

    if param.is_a?(Regexp)
      return false if entry.is_a?(Numeric)

      return param.match(entry)
    end
    (entry == param)
  end
end
