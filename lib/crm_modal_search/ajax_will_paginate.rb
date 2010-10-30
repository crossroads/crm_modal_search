AjaxWillPaginate.class_eval do
  private
  # "Ajaxify" page links by using :remote => true. Also remove the
  # action part from the url, so it always points to :index and looks
  # like /controller?page=N
  #----------------------------------------------------------------------------
  def modal_link(text, target, attributes = {})
    # TODO: figure out where the next and previous links are defined
    text = text.html_safe if String === text
    @template.link_to_remote(text, {
      :url     => url(target).sub(/(#{Setting.base_url}\/\w+)\/[^\?]+\?/, "\\1?"),
      :method  => :get,
      :loading => "$('modal_paging').show()",
      :success => "$('modal_paging').hide()"
    }.merge(@remote))
  end
end
