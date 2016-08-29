require 'generic_controller'
RSpec.describe GenericController do
  controller = nil
  before(:all) do
    module Bongo; end
    class FooBarBaz; end
    module Bongo
      class FooBarBazController < GenericController; end
    end
    controller = Bongo::FooBarBazController.new
  end
  describe '#model' do
    it 'classifies the correct model' do
      expect(controller.send(:model)).to eq(FooBarBaz)
    end
  end
  describe '#page' do
    let(:params) { instance_double('params') }
    let(:page_count) { 2 }
    specify do
      allow(params).to receive(:[]).with(:page).and_return(page_count)
      allow(controller).to receive(:params).and_return(params)
      expect(controller.send(:page)).to eq(page_count)
    end
  end
end
