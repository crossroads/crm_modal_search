[ContactsController, AccountsController].each do |controller|
  controller.class_eval do
    # GET /:controller/modal_search                                      AJAX
    #----------------------------------------------------------------------------
    # Loads an rjs autocomplete template overlay
    def modal_search
      respond_to do |format|
        format.js { render 'common/modal_search', :layout => false }
      end
    end
  end
end
