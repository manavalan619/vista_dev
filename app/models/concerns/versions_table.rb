module VersionsTable
  extend ActiveSupport::Concern

  module ClassMethods
    def versions_table(versions_table_name)
      class_eval do
        self.table_name = versions_table_name
        self.sequence_name = "#{versions_table_name}_id_seq".to_sym
      end
    end
  end
end
