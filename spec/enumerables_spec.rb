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
end