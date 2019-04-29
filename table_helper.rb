module AttributesTable
  module TableHelper
    def attributes_table(record, title, options = {}, color: 'default', &block)
      t = AttributesTable::TableBuilder.new(record, title, self, options)
      content_tag :div, class: "panel panel-#{color}" do
        header = content_tag :div, class: 'panel-heading' do
          title
        end
        table = content_tag :table, class: 'table attributes-table' do
          content_tag :tbody do
            block.yield(t) if block_given?
          end
        end
        header << table
      end
    end
  end
end
