# spec/requests/file_spec.rb
require 'rails_helper'

RSpec.describe 'File API' do
  # Initialize the test data
  let!(:files) { create_list(:api_file, 15) }
  let(:file_id) { files.first.id }
  let(:search_tags_1) { "%2Btag1 %2Btag2 -tag3".html_safe }
  
  describe 'GET /api/v1/files' do
    it 'returns 10 files from first page' do
      get '/api/v1/files'
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    it 'returns 5 files from first page' do
      get '/api/v1/files?page=2'
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns api files based on submitted tags' do 
      get "/api/v1/files?page=1&tag_search_query=#{search_tags_1}"
      failed = false
      json.each{|x| failed = true if ["tag1", "tag2"] && x["tag_list"].length != 2}
      expect(failed).to eq(false)
    end
  end

  # Test suite for POST /api/v1/file
  describe 'POST /api/v1/file' do
    # valid payload
    let(:valid_attributes) { { name: 'Test file name', tag_list: "tag1, tag2" } }
    let(:invalid_attributes) { { name: 'Test file name', tag_list: "tag1, tag2+tag" } }

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

    context 'when the request has invalid tags' do
      before { post '/api/v1/file', params: {api_file: invalid_attributes }}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Tag list Please enter the tags in the right format/)
      end
    end
  end


end