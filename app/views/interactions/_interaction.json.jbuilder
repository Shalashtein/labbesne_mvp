json.extract! interaction, :id, :spree_product_id, :spree_user_id, :expanded, :swiped, :like_count, :dislike_count,
              :bought, :created_at, :updated_at
json.url interaction_url(interaction, format: :json)
