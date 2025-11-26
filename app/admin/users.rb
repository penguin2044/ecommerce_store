ActiveAdmin.register User do
  # Remove auto-generated filters
  config.filters = true

  # Add only filters that exist and are safe
  filter :email
  filter :created_at
  filter :updated_at
  filter :sign_in_count
end

