
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#index' do
    it "should return success" do
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
    end
  end
end
