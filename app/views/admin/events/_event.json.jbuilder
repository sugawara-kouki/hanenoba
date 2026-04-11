json.extract! event, :id, :title, :event_type_id, :capacity, :held_at, :location, :status, :created_at, :updated_at
json.url event_url(event, format: :json)
