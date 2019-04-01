module Response
  def json_response(object, status = :ok)
    if(object.kind_of?(ActiveRecord::Relation))
      related_tags = []
      object.each do |obj|
        obj.tags.each do |tag|
          related_tags << {tag: tag.name, file_count: tag.taggings_count} unless @select_tags and @select_tags.include? tag.name
        end
      end
      render json: object,
             status: status,
             total_records: object.count,
             related_tags: related_tags.uniq,
             records: object

    else
      render json: object, status: status
    end
  end

end