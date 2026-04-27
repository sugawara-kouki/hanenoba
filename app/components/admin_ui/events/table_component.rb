module AdminUi
  module Events
    class TableComponent < ApplicationComponent
      def initialize(events:, pagy:)
        @events = events
        @pagy = pagy
      end

      private

      attr_reader :events, :pagy
    end
  end
end
