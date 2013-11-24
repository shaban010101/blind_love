module OrderHelper 
  def cancel_order_status_check(o)
    unless o.status == "Canceled"
      content_tag(:form, :method => "put", :action => cancel_user_order_path(current_user, o), :class => "button_to" ) do
        content_tag(:input, nil, :name => "_method", :type => "hidden", :value => "put")
        content_tag(:input, nil, :type => "submit", :value => "Cancel Order",  :class => "btn" )
        content_tag(:input, nil, :name => "authenticity_token", :type => "hidden", :value => "")
      end
    end
  end
end