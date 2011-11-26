require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_modal_search, self) do
          name "Fat Free CRM - Modal Search"
        author "Nathan Broadbent"
       version "0.1"
   description "Filter and search records in a modal window while filling out a form."
  # dependencies 
end

require "crm_modal_search"

Rails.configuration.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, Rails.root.join('public')
