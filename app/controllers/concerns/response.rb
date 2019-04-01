module Response
  def json_response(object, status = :ok)
    if(object.kind_of?(Array))
      render json: object,
             status: status,
             total_records: object.count
    else
      render json: object, status: status
    end
  end
end