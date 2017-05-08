# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Kagu::Bootstrap do
  context 'top level definitions' do
    before { described_class.bootstrap }

    context '#link_activerecord_models' do 
      it 'should class alias all top level models' do
        expect(Object.constants).to include(
          *Kagu::Models.constants.inject([]) do |m, i|
            m << i if Kagu::Models.const_get(i) < ActiveRecord::Base
            m
          end
        )
      end
    end
  end

  context '#configure_elasticsearch_client' do
    let(:url) { 'foo.com' }
    before { ENV['ELASTICSEARCH_URL'] = url }

    it 'should use the environment variable if present' do
      expect(::Elasticsearch::Client)
        .to receive(:new).with(host: url, log: true)

      described_class.bootstrap
    end

    context 'with no env var' do 
      let(:url) { nil }

      it 'should use localhost otherwise' do
        expect(::Elasticsearch::Client)
          .to receive(:new).with(host: 'localhost:9200', log: true)
        described_class.bootstrap
      end
    end
  end
end
