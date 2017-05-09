describe Kagu::Adapters::S3 do

  context 'with stubbed bucket' do
    let(:bucket) { double }
    let(:object) { double }

    before(:example) do
      %i(@bucket @resource).each do |v|
        described_class.instance.instance_variable_set(v, nil)
      end

      expect_any_instance_of(Aws::S3::Resource)
        .to receive(:bucket).at_most(:once)
        .and_return(bucket)
    end

    context '.object_by_key' do
      let(:key) { 'foobar.avi' }

      after { described_class.object_by_key(key) }

      it 'calls the correct methods' do
        expect(bucket).to receive(:object).with(key).and_return(object)
      end
    end

    context '.upload_file' do
      let(:temp_file) { Tempfile.new('foo').tap { |f| f.write('hi') } }
      let(:filename) { 'foo.txt' }
      let(:random_hash) { 'bar123' }

      after { described_class.upload_file(temp_file.path, filename) }

      it 'should invoke the correct methods' do
        expect(SecureRandom).to receive(:uuid).and_return(random_hash)

        expect(bucket).to receive(:object)
          .with("#{random_hash}.txt")
          .and_return(object)

        expect(object).to receive(:upload_file).with(temp_file.path)
      end
    end

    context '.file_to_buffer' do
      let(:s3_url) { 'foo/bar/baz.avi' }

      after { described_class.file_to_buffer(s3_url) }

      it 'should invoke the correct methods' do 
        expect(bucket).to receive(:object).with(s3_url).and_return(object)
        expect(object).to receive(:get)
      end
    end
  end
end