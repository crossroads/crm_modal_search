//----------------------------------------------------------------------------
// Sets a 'mousedown' event listener on a specified asset dropdown,
// and AJAX loads a modal dialog to select an asset.
// The selectlist is then set to the returned value as a callback.
crm.set_modal_search = function(el_id, controller) {

  // Replace the element with a hidden input.
  var el_name = $(el_id).getAttribute('name');
  $(el_id).replace('<br/><input type="hidden" name="'+el_name+'" id="'+el_id+'" value="">'+
                   '<div class="modaldisplaybox" id="'+el_id+'_modalbox">'+
                   '<div class="modaldisplay-label" id="'+el_id+'_label">-- No account selected --</div>'+
                   '<a class="modaldisplay-button" href="#" '+
                   "onclick=\"Modalbox.show('/"+controller+"/modal_search.html?update_el="+el_id+"', "+
                   "{ title: 'Select Account', width: 800,"+
                   " beforeLoad: function(){ el=$('paging'); if(el){ el.setAttribute('id', 'paging-main'); } },"+
                   " afterHide:  function(){ el=$('paging-main'); if(el){ el.setAttribute('id', 'paging'); } }" +
                   " }); return false;\">select</div></div>");
};


//----------------------------------------------------------------------------
// Duplicates the crm.search function, but adding a 'search_type => modal' param
crm.modal_search = function(query, controller, update_el) {
  if (!this.request) {
    var list = controller;          // ex. "users"
    if (list.indexOf("/") >= 0) {   // ex. "admin/users"
      list = list.split("/")[1];
    }
    $("modal_loading").show();
    $(list).setStyle({ opacity: 0.4 });
    new Ajax.Request(this.base_url + "/" + controller + "/search", {
      method     : "get",
      parameters : { query: query, search_type: 'modal', update_el: update_el },
      onSuccess  : function() {
        $("modal_loading").hide();
        $(list).setStyle({ opacity: 1 });
      },
      onComplete : (function() { this.request = null; }).bind(this)
    });
  }
}
