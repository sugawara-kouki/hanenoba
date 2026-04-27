module AdminUi
  class CardComponent < ApplicationComponent
    renders_one :header_action

    def initialize(title:, icon: nil)
      @title = title
      @icon = icon
    end
  end
end
