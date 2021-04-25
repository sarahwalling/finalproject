require './lib/longest_common_prefix'

describe LongestCommonPrefix do

  pending 'should return a complete array element that is a prefix in each element of the array' do
    expect(subject.longest_common_prefix(['abc', 'abcd', 'abcd3fa'])).to  eq('abc')
  end

  pending 'should return an empty string for nil array' do
    expect(subject.longest_common_prefix(nil)).to  eq('')
  end

  pending 'should return an empty string for empty array' do
    expect(subject.longest_common_prefix([])).to  eq('')
  end

  pending 'should return an empty string for no common prefix' do
    expect(subject.longest_common_prefix(['a', 'b'])).to eq('')
    expect(subject.longest_common_prefix(['abab', 'aba', ''])).to eq('')
  end

  pending "should return 'fl' as a common prefix" do
    expect(subject.longest_common_prefix(['flower','flow','flight'])).to eq('fl')
  end

end
