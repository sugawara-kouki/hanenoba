module AdminUi
  class FormBuilder < ActionView::Helpers::FormBuilder
    attr_reader :template

    COMMON_CLASSES = "block w-full rounded-xl border-0 px-4 py-3 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 transition-all".freeze

    LABEL_CLASSES = "block text-sm font-bold text-gray-700 mb-2".freeze

    def label(method, text = nil, options = {}, &block)
      options[:class] = "#{LABEL_CLASSES} #{options[:class]}"
      super(method, text, options, &block)
    end

    (field_helpers - %i[label check_box radio_button fields_for fields hidden_field]).each do |method|
      define_method(method) do |name, options = {}|
        options[:class] = template.sanitize_to_id("#{COMMON_CLASSES} #{options[:class]}")
        super(name, options)
      end
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      html_options[:class] = "#{COMMON_CLASSES} #{html_options[:class]}"
      super(method, choices, options, html_options, &block)
    end

    def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
      html_options[:class] = "#{COMMON_CLASSES} #{html_options[:class]}"
      super(method, collection, value_method, text_method, options, html_options)
    end
  end
end
