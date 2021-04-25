require './lib/contains_duplicate'

describe ContainsDuplicate do

  pending 'should return true when it contains duplicate elements' do
    expect(subject.contains_duplicate([1,1,3])).to eq(true)
  end

  pending 'should return true when it does not contain duplicates' do
    expect(subject.contains_duplicate([1,2,3,4])).to eq(false)
  end

  pending 'should return true when it does not contain any element' do
    expect(subject.contains_duplicate([])).to eq(true)
  end

end