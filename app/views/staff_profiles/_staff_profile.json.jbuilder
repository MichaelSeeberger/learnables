json.extract! staff_profile, :id, :name, :user_id, :created_at, :updated_at
json.url staff_profile_url(staff_profile, format: :json)
