module IconHelper
  # Lucide-like SVG icons
  def icon(name, options = {})
    classes = options[:class] || "h-5 w-5"
    
    case name.to_sym
    when :chevron_up
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round", class: classes) do
        tag(:path, d: "m18 15-6-6-6 6")
      end
    when :chevron_down
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round", class: classes) do
        tag(:path, d: "m6 9 6 6 6-6")
      end
    when :chevrons_up_down
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round", class: classes) do
        concat tag(:path, d: "m7 15 5 5 5-5")
        concat tag(:path, d: "m7 9 5-5 5 5")
      end
    when :plus
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round", class: classes) do
        tag(:path, d: "M12 5v14M5 12h14")
      end
    when :trash
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round", class: classes) do
        concat tag(:path, d: "M3 6h18")
        concat tag(:path, d: "M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6")
        concat tag(:path, d: "M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2")
      end
    when :edit
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round", class: classes) do
        concat tag(:path, d: "M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z")
        concat tag(:path, d: "m15 5 4 4")
      end
    else
      "No Icon Found"
    end
  end
end
