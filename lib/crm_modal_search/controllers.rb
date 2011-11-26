AccountsController.class_eval do
  # GET /accounts/search/query                                             AJAX
  #----------------------------------------------------------------------------
  def search_with_modal_filter
    if params[:search_type] == "modal"
      page = params[:page].blank? ? 1 : params[:page] # Handle blank page param
      @accounts = get_accounts(:query => params[:query], :page => page)

      respond_to do |format|
        format.js   { render :action => :modal_search }
        format.xml  { render :xml => @accounts.to_xml }
      end
    else
      search_without_modal_filter
    end
  end
  alias_method_chain :search, :modal_filter
end


ContactsController.class_eval do
  # GET /contacts/search/query                                             AJAX
  #----------------------------------------------------------------------------
  def search_with_modal_filter
    if params[:search_type] == "modal"
      page = params[:page].blank? ? 1 : params[:page] # Handle blank page param
      @contacts = get_contacts(:query => params[:query], :page => page)

      respond_to do |format|
        format.js   { render :action => :modal_search }
        format.xml  { render :xml => @accounts.to_xml }
      end
    else
      search_without_modal_filter
    end
  end
  alias_method_chain :search, :modal_filter
end

# Generic extensions
#----------------------------------------------------------------------------

[ContactsController, AccountsController].each do |controller|
  controller.class_eval do
    # GET /:controller/modal_search                                          AJAX
    #----------------------------------------------------------------------------
    # Returns the html of the search template
    def modal_search
      respond_to do |format|
        format.html { render 'shared/modal_search',
                             :layout => false }
      end
    end
    
    # Index action is called for pagination, but just does the same as search.
    #----------------------------------------------------------------------------
    def index_with_modal_filter
      params[:search_type] == "modal" ? search_with_modal_filter : index_without_modal_filter
    end
    alias_method_chain :index, :modal_filter
    
  end
end


# Until our rails 3 patch is accepted, we need to delete blank account ids.
#----------------------------------------------------------------------------
OpportunitiesController.class_eval do
  def create_with_account_fix
    params[:account].delete(:id) if params[:account] && params[:account][:id].blank?
    create_without_account_fix
  end
  alias_method_chain :create, :account_fix
end
