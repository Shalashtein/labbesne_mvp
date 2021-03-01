json.extract! body_measurement, :id, :profiles_id, :body_types_id, :height, :weight, :shirt_size, :pants_size,
              :shoe_size, :created_at, :updated_at
json.url body_measurement_url(body_measurement, format: :json)
