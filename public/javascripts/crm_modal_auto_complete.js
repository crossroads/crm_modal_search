//----------------------------------------------------------------------------
// Sets a 'mousedown' event listener on a specified asset dropdown,
// and AJAX loads a modal dialog to select an asset.
// The selectlist is then set to the returned value as a callback.
crm.set_modal_search = function(el_id, controller) {
  $(el_id).replace('<br/><a title="Show Modal Search" id="'+el_id+'" href="#" '+
                   "onclick=\"Modalbox.show('/"+controller+"/modal_search', "+
                   "{ title: 'Select Account', width: 800 }); return false;\">"+
                   "Please click here to select an account</a>");
};


//----------------------------------------------------------------------------
// Duplicates the crm.search function, but adding a 'search_type => modal' param
crm.modal_search = function(query, controller) {
  if (!this.request) {
    var list = controller;          // ex. "users"
    if (list.indexOf("/") >= 0) {   // ex. "admin/users"
      list = list.split("/")[1];
    }
    $("loading").show();
    $(list).setStyle({ opacity: 0.4 });
    new Ajax.Request(this.base_url + "/" + controller + "/search", {
      method     : "get",
      parameters : { query : query, search_type: 'modal' },
      onSuccess  : function() {
        $("loading").hide();
        $(list).setStyle({ opacity: 1 });
      },
      onComplete : (function() { this.request = null; }).bind(this)
    });
  }
}
