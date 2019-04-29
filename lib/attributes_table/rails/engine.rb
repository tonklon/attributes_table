module AttributesTable
  module Rails
    class Engine < ::Rails::Engine

      initializer 'attribute_table.helpers' do
        ActiveSupport.on_load(:action_view) do
          include AttributesTable::TableHelper
        end
      end
    end
  end
end
