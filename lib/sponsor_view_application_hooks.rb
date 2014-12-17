#class SponsorViewHeaderHooks < Redmine::Hook::ViewListener

#  def view_layouts_base_html_head(context = {})
 #   o = stylesheet_link_tag('sticky_messages', :plugin => 'sponsor_view')
   # o << stylesheet_link_tag('buttons', :plugin => 'sponsor_view')
   # o << javascript_include_tag('sticky_messages', :plugin => 'redmine_sticky_messages')
   # o << javascript_include_tag('jquery.noty.packaged.min.js', :plugin => 'redmine_sticky_messages')
#    return o
#  end
#end

class SponsorAccountViewHook < Redmine::Hook::ViewListener
  render_on :view_my_account_contextual, :partial => 'my/after_account_menu' 
end

#class StickyMessageTopMenuHooks < Redmine::Hook::ViewListener
#  render_on :view_layouts_base_body_bottom, :partial => 'messages/after_top_menu'
#end
