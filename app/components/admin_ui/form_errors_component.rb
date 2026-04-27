module AdminUi
  class FormErrorsComponent < ViewComponent::Base
    def initialize(model:)
      @model = model
    end

    def render?
      @model.errors.any?
    end

    private

    attr_reader :model
  end
end
