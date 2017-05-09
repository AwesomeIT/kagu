# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sample, type: :model do
  context '#private_url' do
    let(:sample) { FactoryGirl.create(:sample) }
    let(:object) { double }


    it 'should call the s3 adapter correctly' do 
      expect(Kagu::Adapters::S3).to receive(:object_by_key)
        .with(sample.s3_key).and_return(object)

      expect(object).to receive(:presigned_url)
        .with(:get, expires_in: 3600)

      sample.private_url
    end 
  end
end
