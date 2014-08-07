require 'spec_helper'

describe Fountain::DSL do

  it 'returns a single image for a single image block' do
    image_set = Fountain::ImageSet.new
    image_set.in_context do
      image :simple, from: 'busybox'
    end
    expect(image_set.size).to eq(1)
    image = image_set[:simple]
    expect(image.name).to eq(:simple)
    expect(image.from).to eq('busybox')
  end
end
