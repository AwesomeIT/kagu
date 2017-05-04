describe Kagu::Search::StoreAdapters::ActiveRecord do
  let(:klass) { Experiment }

  context '.attribute_type' do
    let(:attribute) { 'foo' }
    let(:columns_hash) { { attribute => OpenStruct.new(type: 'bar') } }

    it 'should invoke the correct methods' do
      expect(klass).to receive(:columns_hash).twice
      expect(klass).to receive_message_chain(
        :columns_hash, :key?
      ).with(attribute).and_return(true)

      expect(klass).to receive_message_chain(
        :columns_hash, :[], :type
      )

      described_class.attribute_type(klass, attribute)
    end

    it 'should return the correct value' do 
      allow(klass).to receive(:columns_hash).and_return(columns_hash) 
      expect(described_class.attribute_type(klass, attribute)).to eql('bar')
    end

    it 'should raise an exception if the attribute is not present' do 
      allow(klass).to receive_message_chain(
        :columns_hash, :key?).and_return(false)

      expect { described_class.attribute_type(klass, attribute) }
        .to raise_error(Kagu::Search::Exceptions::InvalidAttributeError)
    end
  end
end