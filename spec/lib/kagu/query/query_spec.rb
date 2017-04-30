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
    subject { described_class.new(klass) }

    let!(:klass) do
      Class.new do
        def self.by_tags(_)
          OpenStruct.new(records: Experiment.all)
        end

        def self.by_name(_)
          OpenStruct.new(records: Experiment.all)
        end
      end
    end

    let(:query) { { by_tags: 'a', by_name: 'b' } }

    it 'invokes the correct search methods' do
      expect(klass).to receive(:by_tags).with('a').and_call_original
      expect(klass).to receive(:by_name).with('b').and_call_original

      subject.search(query)
    end

    it 'merges the relations' do
      expect_any_instance_of(ActiveRecord::Relation)
        .to receive(:merge).and_call_original
      subject.search(query) 
    end

    it 'sets the last query' do
      subject.search(query)
      expect(subject.last_query).to eql(query) 
    end
  end
end