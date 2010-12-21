class ModalSearchViewHooks < FatFreeCRM::Callback::Base

  # Attaches javascript events at the end of each new opportunity rjs template
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Account & Contact modal search
  def modal_search_account_and_contact(view, context = {})
    context[:page].call "crm.set_modal_search", 'account_id', 'accounts'
    context[:page].call "crm.set_modal_search", 'contact_id', 'contacts'
  end
  # Account modal search 
  def modal_search_account(view, context = {})
    context[:page].call "crm.set_modal_search", 'account_id', 'accounts'
  end

  # Alias hooks
  
  # opportunity create/edit
  alias :new_opportunity_rjs  :modal_search_account_and_contact
  alias :edit_opportunity_rjs :modal_search_account_and_contact
  # contact create/edit
  alias :new_contact_rjs      :modal_search_account
  alias :edit_contact_rjs     :modal_search_account
  # convert lead
  alias :convert_lead_rjs     :modal_search_account
  
  #----------------------------------------------------------------------------
  def javascript_includes(view, context = {})
    # Load the plugin javascript extensions
    includes = view.javascript_include_tag 'crm_modal_search.js'
    includes << view.stylesheet_link_tag('crm_modal_search.css')    
  end

end

