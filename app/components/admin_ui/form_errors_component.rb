module AdminUi
  class FormErrorsComponent < ApplicationComponent
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
