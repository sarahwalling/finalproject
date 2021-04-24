require './lib/distribute_candies'

describe DistributeCandies do

  it 'should return 3 for the array = [1,1,2,2,3,3]' do
    expect(subject.distribute_candies([1,1,2,2,3,3])).to eq(3)
  end

  it 'should return 2 for the array = [1,1,2,3]' do
    expect(subject.distribute_candies([1,1,2,3])).to eq(2)
  end

end