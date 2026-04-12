module ApplicationHelper
  def sort_link(column, title, options = {})
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    is_active = column == params[:sort]
    
    link_to request.params.merge(sort: column, direction: direction), 
            class: "group inline-flex items-center space-x-1 #{is_active ? 'text-indigo-600' : 'text-gray-400 hover:text-gray-600'} transition-all" do
      concat content_tag(:span, title, class: "border-b border-transparent group-hover:border-current")
      
      icon_name = if is_active
                    params[:direction] == "asc" ? :chevron_up : :chevron_down
                  else
                    :chevrons_up_down
                  end
      
      concat icon(icon_name, class: "h-3.5 w-3.5 #{is_active ? 'text-indigo-600' : 'text-gray-300 group-hover:text-gray-500 transition-colors'}")
    end
  end
end
