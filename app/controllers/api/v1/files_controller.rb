module Api
  module V1
    class FilesController < ApplicationController
      
      def index
        @api_files = ApiFile.all
        params[:page] ||= 1
        if params[:tag_search_query]
          tags = params[:tag_search_query].split(" ")
          @select_tags = tags.select{|tag| tag[0]=='+'}.map{|tag| tag[1..-1]}
          @deselect_tags = tags.select{|tag| tag[0]=='-'}.map{|tag| tag[1..-1]}
          @api_files = @api_files.tagged_with(@select_tags, :match_all => false) - @api_files.tagged_with(@deselect_tags, :match_all => false) 
        else
          @api_files = @api_files.page params[:page]
        end
        json_response(@api_files)
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