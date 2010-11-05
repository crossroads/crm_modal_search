//----------------------------------------------------------------------------
// AJAX loads a modal dialog to select an asset.
// A hidden input and label is then set, to display and post the returned asset.
crm.set_modal_search = function(el_id, controller) {
  // Replace onclick events for (create new or select existing)
  // -- 'create new' link
  //$$('span#account_select_title a')[0].setAttribute('onclick', 'crm.modal_create_account_field(1); return false;');
  // -- 'select existing' link
  //$$('span#account_create_title a')[0].setAttribute('onclick', 'crm.modal_select_account_field(1); return false;');

  // Replace the element with a hidden input, add modal display box.
  var el_name = $(el_id).getAttribute('name');
  var visible = $(el_id).visible();
  
  $(el_id).replace('<br/><input type="hidden" name="'+el_name+'" id="'+el_id+'" value="">'+
                   '<div class="modaldisplaybox" id="'+el_id+'_modalbox">'+
                   '<div class="modaldisplay-label" id="'+el_id+'_label">-- No account selected --</div>'+
                   '<a class="modaldisplay-button" href="#" '+
                   "onclick=\"Modalbox.show('/"+controller+"/modal_search.html?update_el="+el_id+"', "+
                   "{ title: 'Select Account', width: 800,"+
                   " beforeLoad: function(){ el=$('paging'); if(el){ el.setAttribute('id', 'paging-main'); } },"+
                   " afterHide:  function(){ el=$('paging-main'); if(el){ el.setAttribute('id', 'paging'); } }" +
                   " }); return false;\">select</div></div>");
  
  // Preserve the state of the input when validation returns
  if (!visible) {
    $(el_id+"_modalbox").hide();
    $(el_id).hide();
    $(el_id).disable();
  };
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



// Hide accounts dropdown and show create new account edit field instead.
//----------------------------------------------------------------------------
crm.create_account = function(and_focus) {
  if($("account_id_modalbox")) $("account_id_modalbox").hide();
  
  $("account_disabled_title").hide();
  $("account_select_title").hide();
  $("account_create_title").show();
  $("account_id").hide();
  $("account_id").disable();
  $("account_name").enable();
  $("account_name").clear();
  $("account_name").show();
  if (and_focus) {
    $("account_name").focus();
  }
};

// Hide create account edit field and show accounts dropdown instead.
//----------------------------------------------------------------------------
crm.select_account = function(and_focus) {
  if($("account_id_modalbox")) $("account_id_modalbox").show();
  
  $("account_disabled_title").hide();
  $("account_create_title").hide();
  $("account_select_title").show();
  $("account_name").hide();
  $("account_name").disable();
  $("account_id").enable();
  $("account_id").show();
};

// Hide contacts dropdown and show create new contact form instead.
//----------------------------------------------------------------------------
crm.modal_create_contact_field = function(and_focus) {
  //$("contact_id_modalbox").hide();
  
  $("contact_disabled_title").hide();
  $("contact_select_title").hide();
  $("contact_create_title").show();
  $("contact_id").hide();
  $("contact_id").disable();

  crm.wizard_contact();

  if (and_focus) {
    $("contact_first_name").focus();
  }
};

// Hide create contact edit field and show contacts dropdown instead.
//----------------------------------------------------------------------------
crm.modal_select_contact_field = function(and_focus) {
  //$("contact_id_modalbox").show();
  
  $("contact_disabled_title").hide();
  $("contact_create_title").hide();
  $("contact_select_title").show();
  $("create_new_contact_info").hide();
  $("contact_id").enable();
  $("contact_id").show();
};

