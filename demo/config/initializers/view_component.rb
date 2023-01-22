# Setup view components

Rails.application.configure do
  config.view_component.show_previews = true
  config.view_component.preview_paths << Rails.root.join("../previews")
end
