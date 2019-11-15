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

    entry = is_a(Range) ? to_a : self
    i = 0
    while i < size
      yield(entry[i])
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

  def my_all?; end

  def my_any?; end

  def my_none?; end

  def my_count; end

  def my_map; end

  def my_inject; end

  def multiply_els; end

  def my_map_with_proc; end

  def my_map_proc_or_block; end
end
