ActiveAdmin.setup do |config|
  config.site_title = "Overthrow"

  config.authentication_method = :authenticate_admin

  config.current_user_method = :current_user

  config.logout_link_path = :destroy_user_session_path

  config.batch_actions = true
end
