class ModalSearchViewHooks < FatFreeCRM::Callback::Base

  insert_after :opportunity_top_section do |view, context|
    view.javascript_tag "crm.set_modal_search('account_id', 'accounts');"
  end

  #----------------------------------------------------------------------------
  def javascript_includes(view, context = {})
    # Load the plugin javascript extensions
    includes = view.javascript_include_tag 'crm_modal_search.js'
    includes << view.stylesheet_link_tag('crm_modal_search.css')    
  end

end

