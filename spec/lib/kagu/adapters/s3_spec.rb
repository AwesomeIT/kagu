describe Kagu::Adapters::S3 do

  context 'with stubbed bucket' do
    context '.upload_file' do
      let(:temp_file) { Tempfile.new('foo').tap { |f| f.write('hi') } }
      let(:filename) { 'foo.txt' }

      let(:random_hash) { 'foo123' }

      after { described_class.upload_file(temp_file.path, filename) }

      it 'should invoke the correct methods' do
        expect_any_instance_of(Aws::S3::Resource)
          .to receive(:bucket).at_most(:once)
          .and_return(
            Aws::S3::Bucket.new(name: 'foo', region: 'test')
          )

        expect(SecureRandom).to receive(:uuid).and_return(random_hash)

        expect_any_instance_of(Aws::S3::Bucket)
          .to receive(:object)
          .with("#{random_hash}.txt")
          .and_return(Aws::S3::Object.new(
            bucket_name: 'foo', key: "#{random_hash}.txt", region: 'us-east-1'
          ))

        expect_any_instance_of(Aws::S3::Object)
          .to receive(:upload_file).with(temp_file.path)
          .and_return(self)
      end
    end

    context '.file_to_buffer' do
      let(:s3_url) { 'foo/bar/baz.avi' }

      after { described_class.file_to_buffer(s3_url) }

      it 'should invoke the correct methods' do 
        expect_any_instance_of(Aws::S3::Bucket)
          .to receive(:object)
          .with(s3_url)
          .and_return(Aws::S3::Object.new(
            bucket_name: 'foo', key: s3_url, region: 'us-east-1'
          ))

        expect_any_instance_of(Aws::S3::Object)
          .to receive(:get)
      end
    end
  end
end