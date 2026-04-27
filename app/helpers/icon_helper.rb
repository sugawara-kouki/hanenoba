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
    when :user_circle
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5zm6-10.125a1.875 1.875 0 11-3.75 0 1.875 1.875 0 013.75 0zm1.294 6.336a6.721 6.721 0 01-3.17.789 6.721 6.721 0 01-3.168-.789 3.376 3.376 0 016.338 0z")
      end
    when :ban
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636")
      end
    when :check_circle
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z")
      end
    when :plus
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2", stroke_linecap: "round", stroke_linejoin: "round", class: classes) do
        tag(:path, d: "M12 5v14M5 12h14")
      end
    when :info
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z")
      end
    when :chevron_right
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M9 5l7 7-7 7")
      end
    when :home
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6")
      end
    when :search
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z")
      end
    when :chevron_left
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "3", d: "M15 19l-7-7 7-7")
      end
    when :arrow_right
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "3", d: "M13 7l5 5m0 0l-5 5m5-5H6")
      end
    when :check
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "4", d: "M5 13l4 4L19 7")
      end
    when :tag
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z")
      end
    when :exclamation_triangle
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z")
      end
    when :lock
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z")
      end
    when :refresh
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15")
      end
    when :document_text
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z")
      end
    when :chart_bar
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z")
      end
    when :calendar
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z")
      end
    when :location
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        concat tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z")
        concat tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M15 11a3 3 0 11-6 0 3 3 0 016 0z")
      end
    when :users
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z")
      end
    when :eye
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        concat tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M15 12a3 3 0 11-6 0 3 3 0 016 0z")
        concat tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z")
      end
    when :trash
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16")
      end
    when :edit
      content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: classes) do
        tag(:path, stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z")
      end
    else
      "No Icon Found"
    end
  end
end
