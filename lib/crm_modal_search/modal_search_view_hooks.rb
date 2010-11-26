class ModalSearchViewHooks < FatFreeCRM::Callback::Base

  # Attaches javascript events at the end of each new opportunity rjs template
  def new_opportunity_rjs(view, context = {})
    context[:page].call "crm.set_modal_search", 'account_id', 'accounts'
    context[:page].call "crm.set_modal_search", 'contact_id', 'contacts'
  end

  #----------------------------------------------------------------------------
  def javascript_includes(view, context = {})
    # Load the plugin javascript extensions
    includes = view.javascript_include_tag 'crm_modal_search.js'
    includes << view.stylesheet_link_tag('crm_modal_search.css')    
  end

end

