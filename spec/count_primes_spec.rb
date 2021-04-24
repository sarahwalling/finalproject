require './lib/count_primes'

describe CountPrimes do

  it 'should return 0 for 0' do
    expect(subject.count_primes(0)).to eq(0)
  end

  it 'should return 0 for 1' do
    expect(subject.count_primes(1)).to eq(0)
  end

  it 'should return 4 for 2' do
    expect(subject.count_primes(4)).to eq(2)
  end


end