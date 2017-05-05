describe Kagu::Search::ActiveModelMapper do
  let(:dummy_adapter) do
    class Foo < Kagu::Search::StoreAdapters::Base
      class << self
        def attribute_type(*args)
          'string'
        end

        def derived_type(*args)
          'string'
        end
      end
    end 
  end

  let(:klass) { double }

  subject { described_class.new(klass) }

  before do
    allow_any_instance_of(described_class)
      .to receive(:store_adapter).and_return(dummy_adapter)
  end

  context 'DSL' do
    context '#attributes' do
      let(:attrs) { %i(foo bar) }

      it 'adds attributes correctly' do
        subject.attributes(*attrs)
        expect(subject.send(:fields).keys).to include(*attrs.map(&:to_s))
      end 
    end

    context '#derived' do
      it 'adds derived fields correctly' do
        subject.derived(:foofield, :get_foo, :string)
        expect(subject.send(:fields).keys).to include('foofield')
        expect(subject.send(:fields)['foofield'][:_mapper_type])
          .to eql(:derived)
      end
    end

    context '#searchable' do
      let(:mapped_fields) { double }

      it 'calls the correct methods and yields' do
        expect(subject).to receive(:mapped_fields).and_return(mapped_fields)
        expect(klass).to receive(:class_exec).and_return(true)
        expect(klass).to receive(:define_method).and_return(true)
        expect { |b| subject.searchable(&b) }.to yield_control
      end
    end
  end

  context '#derived_as_json' do
    let(:instance) { OpenStruct.new(foobius: 'barius') }
    let(:fields) { { foobius: { getter: :foobius } } }

    it 'should retrieve the field from the other object' do
      expect(subject).to receive(:fields).and_return(fields)

      expect(subject.derived_as_json(instance)).to eql(
        { foobius: 'barius' }
      ) 
    end
  end
end