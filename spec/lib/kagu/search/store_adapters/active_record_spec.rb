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

  context '.relation_type' do 
    let(:relation) { 'bar' }
    let(:reflections) { { 'bar' => double } }

    let(:user_settings) { { type: 'string'} }

    it 'should invoke the correct methods' do
      allow(klass).to receive(:reflections).and_return(reflections)

      expect(klass).to receive_message_chain(
        :reflections, :key?).with(relation).and_call_original

      expect(user_settings).to receive(:[]).with(:type).and_call_original

      expect(
        described_class.relation_type(klass, relation, user_settings)
      ).to eql('string')
    end

    it 'should raise an exception for non existing relations' do
      allow(klass).to receive_message_chain(
        :reflections, :key?).with(relation).and_return(false)

      expect { described_class.relation_type(klass, relation, user_settings) }
        .to raise_error(Kagu::Search::Exceptions::InvalidRelationError)
    end
  end
end