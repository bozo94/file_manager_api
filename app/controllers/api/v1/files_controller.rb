module Api
  module V1
    class FilesController < ApplicationController
      
      def index
      end

      def create
        @api_file = ApiFile.create!(api_file_params)
        json_response(@api_file, :created)
      end

      private

        def api_file_params
          params.require(:api_file).permit(:name, :tag_list)
        end 

    end
  end
end