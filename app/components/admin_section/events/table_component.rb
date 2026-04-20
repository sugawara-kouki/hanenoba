module AdminSection
  module Events
    class TableComponent < ViewComponent::Base
      def initialize(events:, pagy:)
        @events = events
        @pagy = pagy
      end

      private

      attr_reader :events, :pagy
    end
  end
end
