require './lib/reverse_integer'

describe ReverseInteger do
  pending 'should return 0 when the reversed is larger than max integer' do
    expect(subject.reverse(1534236469)).to eq(0)
  end

  pending 'should return -123' do
    expect(subject.reverse(-321)).to eq(-123)
  end

  pending 'should return 1234567' do
    expect(subject.reverse(1234567)).to eq(7654321)
  end
end