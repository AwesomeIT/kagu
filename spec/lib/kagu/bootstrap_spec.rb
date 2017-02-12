require 'spec_helper'

RSpec.describe Kagu::Bootstrap do
  context 'top level definitions' do 
    before { described_class.bootstrap }

    it 'should class alias all top level models' do 
      expect(Object.constants).to include(*Kagu::Models.constants)
    end

    it 'should have class types' do 
      expect { Kagu::Models.constants.map {|c| c.to_s.constantize} }
        .to_not raise_error
    end
  end
end