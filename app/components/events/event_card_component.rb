module Events
  class EventCardComponent < ViewComponent::Base
    def initialize(event:, current_user:)
      @event = event
      @current_user = current_user
    end

    private

    attr_reader :event, :current_user

    def booked?
      @booked ||= event.booked_by?(current_user)
    end

    def full?
      @full ||= event.full?
    end

    def disabled?
      booked? || full?
    end

    def card_classes
      classes = "group relative bg-white rounded-[2.5rem] shadow-sm ring-1 ring-gray-900/5 overflow-hidden hover:shadow-2xl hover:shadow-indigo-500/10 transition-all duration-500 flex flex-col h-full"

      if disabled?
        classes += " opacity-60 grayscale-[0.3]"
      end

      classes
    end
  end
end
