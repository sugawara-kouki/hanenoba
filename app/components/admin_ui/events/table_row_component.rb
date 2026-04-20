module AdminUI
  module Events
    class TableRowComponent < ViewComponent::Base
      def initialize(event:)
        @event = event
      end

      private

      attr_reader :event

      def status_badge_class
        event.published? ? "bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.4)]" : "bg-gray-300"
      end

      def status_text_class
        event.published? ? "text-green-700" : "text-gray-500"
      end

      def progress_bar_width
        [ event.occupancy_rate, 100 ].min
      end
    end
  end
end
