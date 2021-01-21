json.extract! info, :id, :profiles_id, :name, :dob, :gender, :phone, :created_at, :updated_at
json.url info_url(info, format: :json)
