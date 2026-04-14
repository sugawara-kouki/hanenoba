module Calendar
  class DayCellComponent < ViewComponent::Base
    def initialize(date:, base_date:, events: [])
      @date = date
      @base_date = base_date
      @events = events
    end

    private

    attr_reader :date, :base_date, :events

    def today?
      @today ||= (date == Date.today)
    end

    def current_month?
      @current_month ||= (date.month == base_date.month)
    end

    def sunday?
      date.sunday?
    end

    def saturday?
      date.saturday?
    end

    def has_events?
      events.any?
    end

    def container_classes
      base = "relative p-1 sm:p-4 group transition-all duration-300"

      month_state = if current_month?
        if has_events?
          "bg-indigo-50/40 ring-1 ring-inset ring-indigo-500/10 hover:bg-indigo-100/60 hover:shadow-lg hover:shadow-indigo-500/5 cursor-pointer"
        else
          "bg-white"
        end
      else
        "bg-gray-50/20"
      end

      "#{base} #{month_state}"
    end

    def date_color_classes
      if today?
        "bg-indigo-600 text-white shadow-lg shadow-indigo-500/30"
      elsif sunday?
        current_month? ? "text-pink-500" : "text-pink-200"
      elsif saturday?
        current_month? ? "text-indigo-500" : "text-indigo-200"
      else
        current_month? ? "text-gray-900" : "text-gray-300"
      end
    end
  end
end
