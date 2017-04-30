require 'spec_helper'

describe Kagu::Query::Elastic do
  context '.for' do
    let(:klass) { String }

    it 'invokes new' do
      expect(described_class).to receive(:new).with(klass)
      described_class.for(String)
    end
  end

  context '#search' do
    let(:klass) do
      Class.new do
        def self.search(_)
          OpenStruct.new(records: Experiment.all)
        end
      end
    end

    let(:query) { { tags: 'a' } }
    
    subject { described_class.new(klass) }

    it 'invokes the correct search methods' do
      expect(klass).to receive(:search).and_call_original
      subject.search(query)
    end

    # it 'merges the relations' do
    #   expect_any_instance_of(ActiveRecord::Relation)
    #     .to receive(:merge).and_call_original
    #   subject.search(query) 
    # end

    it 'sets the last query' do
      subject.search(query)
      expect(subject.last_query).to match(query) 
    end
  end
end