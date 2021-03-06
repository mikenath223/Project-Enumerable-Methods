# frozen_string_literal: true

require_relative '../main.rb'

RSpec.describe Enumerable do
  let(:test_arr1) { [34, 100, 1, 3, 5] }
  let(:test_arr2) { %w[Rick Ricky Buck James] }
  let(:test_arr3) { [34.5, 17.8, 56.8, 32.1] }
  let(:mixed_array) { [1, 2, 3, :sym, (1..10), { name: 'michgolden', job: 'software engineer' }] }
  let(:array_strings) { %w[foo bar] }
  let(:array_of_integers_and_strings) { test_arr1 + test_arr2 }
  let(:array_nils) { [nils, nils, nils] }
  let(:array_one_nil) { [1, nil, 5] }
  let(:hash) { { name: 'Michgolden' } }
  let(:hash_of_strings) { { 'name' => 'michgolden', 'school' => 'Microverse', 'skill' => 'Full stack dev' } }
  let(:range) { (1..20) }

  describe '#my_each' do
    context 'If no block returns to enum like #each' do
      it do
        expect(test_arr1.my_each).to be_an(Enumerator)
      end
    end

    context 'Expect to run a block like #each' do
      it do
        test = test_arr1.each { |num| p num * 2 }
        expect(test_arr1.my_each { |num| p num * 2 }).to eq(test)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If no block returns to enum like #each' do
      it do
        expect(test_arr1.my_each_with_index).to be_an(Enumerator)
      end
    end

    context 'Expect to run a block like #each_with_index' do
      it do
        test = test_arr1.each_with_index { |num, ind| num + ind }
        expect(test_arr1.my_each_with_index { |num, ind| num + ind }).to eq(test)
      end
    end

    context 'Expect to run a string like #each_with_index' do
      it do
        test = test_arr2.each_with_index { |name, ind| "Name: #{name}, Index: #{ind}" }
        expect(test_arr2.my_each_with_index { |name, ind| "Name: #{name}, Index: #{ind}" }).to eq(test)
      end
    end
  end

  describe '#my_select' do
    context 'If no block returns to enum like #select' do
      it do
        expect(test_arr1.select).to be_an(Enumerator)
      end
    end
    context 'Test1: Selects elements like #select' do
      it do
        test = test_arr1.select(&:odd?)
        expect(test_arr1.my_select(&:odd?)).to eq(test)
      end
    end
    context 'Test2: Selects elements like #select' do
      it do
        test = test_arr3.select { |num| num.to_f > 32.1 }
        expect(test_arr3.my_select { |num| num.to_f > 32.1 }).to eq(test)
      end
    end
  end

  describe '#my_all' do
    context 'If no block runs like #all' do
      it do
        expect(test_arr1.my_all?).to be_truthy
      end
    end
    context 'Integers: is identical to #all with integers' do
      it do
        test = test_arr1.all? { |n| n.is_a? Integer }
        expect(test_arr1.my_all? { |n| n.is_a? Integer }).to eq(test)
      end
    end
    context 'Strings: is identical to #all with strings' do
      it do
        test = test_arr2.all? { |n| n.is_a? String }
        expect(test_arr2.my_all? { |n| n.is_a? String }).to eq(test)
      end
    end
    context 'Regex 1: all strings match' do
      it 'should return true' do
        expect(test_arr2.my_all?(/\w+/)).to be_truthy
      end
    end
    context 'Regex 2: one or more strings don\'t match' do
      it 'should return false' do
        expect(array_of_integers_and_strings.my_all?(/\d+/)).to be_falsy
      end
    end
    context 'Regex 3: no element is a string' do
      it 'should return false' do
        expect(test_arr1.my_all?(/\w+/)).to be_falsy
      end
    end
  end

  describe '#my_any' do
    context 'Runs no block given like #any' do
      it do
        expect(test_arr1.my_any?).to be_truthy
      end
    end
    context 'String: is identical to #any with strings' do
      it do
        test = test_arr2.any? { |n| n.is_a? String }
        expect(test_arr2.any?).to eq(test)
      end
    end
    context 'Integers: is identical to #any with integers' do
      it do
        test = test_arr1.any? { |n| n.is_a? Integer }
        expect(test_arr1.my_any?).to eq(test)
      end
    end
    context 'Regex: is identical to #any with regex' do
      it 'should be true' do
        test = array_strings.any?(/Ri/)
        expect(array_strings.my_any?(/Ri/)).to eq(test)
      end
    end
  end

  describe '#my_none' do
    context 'Returns to false like #none if no block' do
      it 'should equal false' do
        expect(test_arr1.my_none?).to be_falsy
      end
    end
    context 'String: is identical to none with strings' do
      it do
        test = test_arr2.none? { |n| n.is_a? String }
        expect(test_arr2.my_none? { |n| n.is_a? String }).to eq(test)
      end
    end
  end
  context 'Integers: is identical to none with integers' do
    it do
      test = test_arr1.none? { |n| n.is_a? Integer }
      expect(test_arr1.my_none? { |n| n.is_a? Integer }).to eq(test)
    end
  end

  describe '#my_count' do
    context 'runs no block similar to #count' do
      it do
        expect(array_of_integers_and_strings.my_count).to eq(9)
      end
    end
    context 'is identical to #count using parameter' do
      it do
        expect(test_arr1.my_count(34)).to eq(1)
      end
    end
    context 'identical to #count when block is given' do
      it do
        expect(test_arr3.my_count { |n| n > 32.1 }).to eq(2)
      end
    end
  end

  describe '#my_map' do
    context 'runs no block same as #map' do
      it do
        expect(test_arr1.my_map).to be_an(Enumerator)
      end
    end
    context 'runs a block like #map' do
      it do
        test = test_arr1.map { |n| n * 2 }
        expect(test_arr1.my_map { |n| n * 2 }).to eq(test)
      end
    end
    context 'runs a proc like #map' do
      it do
        block = proc { |_key, _val| _val = 'Michgolden Ukeje' }
        expect(hash.my_map(&block)).to eq(['Michgolden Ukeje'])
      end
    end
  end

  describe '#my_inject' do
    context 'runs like #inject' do
      it 'using block, no proc' do
        test = test_arr1.inject { |n1, n2| n1 + n2 }
        expect(test_arr1.my_inject { |n1, n2| n1 + n2 }).to eq(test)
      end
      it 'passing a proc' do
        block = proc { |num1, num2| num1 + num2 }
        test = test_arr1.inject(&block)
        expect(test_arr1.my_inject(&block)).to eq(test)
      end
      it 'accepts a sym' do
        test = test_arr2.inject(:+)
        expect(test_arr2.my_inject(:+)).to eq(test)
      end
      it 'using two arguments' do
        test = range.inject(2, :*)
        expect(range.my_inject(2, :*)).to eq(test)
      end
      it 'using block and an argument' do
        test = range.inject(4) { |num1, num2| num1 + num2 }
        expect(range.my_inject(4) { |num1, num2| num1 + num2 }).to eq(test)
      end
    end
  end
end
