module AttributesTable
  class TableBuilder
    def initialize(record, title, template, options)
      @record = record
      @title = title
      @options = options

      @rows = []
      @template = template
      @policy = template.policy(record)
    end

    delegate :tag, :content_tag, :t, :l, to: :@template

    def attribute(attribute, label_or_opts = nil, opts = {}, &block)
      return unless @policy.visible_attributes.include?(attribute)

      if label_or_opts.is_a?(Hash) && label_or_opts.extractable_options?
        label = nil
        opts = label_or_opts
      else
        label = label_or_opts
        opts = opts
      end

      attribute_tag label, attribute, opts, block
    end

    private

    def attribute_tag(label, attribute, opts, block)
      content_tag(:tr, opts) do
        col1 = content_tag :td, class: 'attribute-label' do
          label || @record.class.human_attribute_name(attribute)
        end
        col2 = content_tag :td, class: 'attribute-value' do
          value(attribute, block)
        end
        col1 << col2
      end
    end

    def value(attribute, block)
      if block
        block.yield
      else
        value = @record.send(attribute)
        value_string value, attribute
      end
    end

    def value_string(value, attribute)
      if value.nil?
        ''
      elsif value === true
        t 'default.true'
      elsif value === false
        t 'default.false'
      elsif @record.respond_to?("#{attribute}_text".to_sym)
        @record.send("#{attribute}_text".to_sym)
      elsif value.is_a?(Date)
        l value
      elsif value.is_a?(DateTime)
        l value
      elsif value.is_a?(Time)
        l value
      elsif value.respond_to?(:to_s)
        value.to_s
      else
        value
      end
    end
  end
end