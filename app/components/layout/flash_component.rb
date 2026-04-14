module Layout
  class FlashComponent < ViewComponent::Base
    def initialize(type:, message:)
      @type = type.to_sym
      @message = message
    end

    private

    attr_reader :type, :message

    def container_classes
      case type
      when :alert
        "mb-8 bg-red-50 border border-red-100 text-red-700 px-5 py-3.5 rounded-2xl flex items-center shadow-sm"
      else # notice
        "mb-8 bg-indigo-50 border border-indigo-100 text-indigo-700 px-5 py-3.5 rounded-2xl flex items-center shadow-sm"
      end
    end

    def icon_color_class
      case type
      when :alert
        "text-red-500"
      else
        "text-indigo-500"
      end
    end

    def icon_path
      case type
      when :alert
        # exclamation-circle (Heroicons v2 Solid)
        "M10 18a8 8 0 100-16 8 8 0 000 16zm.75-11.25a.75.75 0 00-1.5 0v4.5a.75.75 0 001.5 0v-4.5zm0 6a.75.75 0 10-1.5 0 .75.75 0 001.5 0z"
      else
        # check-circle (Heroicons v2 Solid)
        "M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
      end
    end
  end
end
