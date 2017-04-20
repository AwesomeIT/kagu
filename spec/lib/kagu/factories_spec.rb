# frozen_string_literal: true
describe 'Factories' do
  context 'when required' do
    before { require 'kagu/factories' }

    let(:factories_defined) do
      Dir["#{Kagu.root}/lib/kagu/factories/**/*.rb"].map do |f|
        f.gsub('_factory.rb', '').split('/').last.to_sym
      end
    end

    it 'should have all of the factories that are defined' do
      expect(FactoryGirl.factories.map(&:name)).to include(*factories_defined)
    end
  end
end
