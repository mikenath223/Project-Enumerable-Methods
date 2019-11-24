require './main.rb'

RSpec.describe Enumerable do
  let(:test_arr1) { [34, 100, 1, 3, 5] }
  let(:test_arr2) { ['Rick', 'Ricky', 'Buck', 'James'] }
  let(:test_arr3) { [34.5, 17.8, 56.8, 32.1] }
  let(:mixed_array) { [1,2,3, 'horse', 'sheep', 'cows', :sym, (1..10), { name: 'michgolden', job: 'software engineer' }] }
  let(:array_strings) { %w(foo bar) }
  let(:array_of_integers_and_strings) { test_arr1 + test_arr2 }
  let(:array_nils) { [nils, nils, nils] }
  let(:array_one_nil) { [1, nil, 5] }
  let(:hash) { { name: 'Michgolden', job: 'developer' } }
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
        test = test_arr1.each {|num| num * 2}
        expect(test_arr1.my_each {|num| num * 2}).to eq(test)
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
        test = test_arr1.each_with_index {|num, ind| num + ind}
        expect(test_arr1.my_each_with_index {|num, ind| num + ind})
      end
    end

    context 'Expect to run a string like #each_with_index' do
      it do
        test = test_arr2.each_with_index { |name, ind| "Name: #{name}, Index: #{ind}"}
        expect(test_arr2.my_each_with_index { |name, ind| "Name: #{name}, Index: #{ind}"}).to eq(test)
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
        expect(test_arr1.my_select(&:odd?))
      end
    end
    context 'Test2: Selects elements like #select' do
      it do
        test = test_arr3.select{ |num| num.to_f > 32.1 }
        expect(test_arr3.my_select{ |num| num.to_f > 32.1 }).to eq(test)
      end
    end
  end

