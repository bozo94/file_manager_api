# spec/requests/items_spec.rb
require 'rails_helper'

RSpec.describe 'Items API' do
  # Initialize the test data
  
  # Test suite for POST /api/v1/file
  describe 'POST /api/v1/file' do
    # valid payload
    let(:valid_attributes) { { name: 'Test file name', tag_list: ['tag1', 'tag2'] } }

    context 'when the request is valid' do
      before { post '/api/v1/file', params: {api_file: valid_attributes }}

      it 'creates a file' do
        expect(json['name']).to eq('Test file name')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/file', params: { api_file: { name: nil } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end


end