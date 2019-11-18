# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    entry = is_a?(Range) ? to_a : self
    i = 0
    while i < size
      yield(entry[i])
      i += 1
    end
    entry
  end

  def my_each_with_index
    return to_enum unless block_given?

    entry = is_a?(Range) ? to_a : self
    i = 0
    while i < size
      yield(entry[i], i)
      i += 1
    end
    entry
  end

  def my_select
    return to_enum unless block_given?

    arr_new = []
    my_each { |elem| arr_new << elem if yield(elem) }
    arr_new
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |elem| return false unless yield(elem) }
    end
    if arg.nil?
      my_each { |elem| return false unless elem }
      return true
    end
    my_each { |elem| return false unless check_validity(elem, arg) }
    true
  end

  def my_any?(arg = nil, &proc)
    if block_given?
      my_each { |elem| return true if proc.nil? ? proc.call(elem) : yield(elem) }
    else
      my_each { |elem| return true if arg.nil? ? elem : check_validity(elem, arg) }
    end
    false
  end

  def my_none?(pattern = nil, &proc)
    !my_any?(pattern, &proc)
  end

  def my_count(num = nil)
    count = 0
    if num
      my_each { |elem| count += 1 if elem == num }
    elsif block_given?
      my_each { |elem| count += 1 if yield(elem) }
    else
      count = length
    end
    count
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
