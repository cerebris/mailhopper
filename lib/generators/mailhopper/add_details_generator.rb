require 'rails/generators'
require 'rails/generators/migration'

module Mailhopper
  module Generators
    class AddDetailsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Add details to Mailhopper email.'

      source_root File.join(File.dirname(__FILE__), 'templates')

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def copy_migration_file
        migration_template 'migrations/add_details_to_emails.rb',
          'db/migrate/add_details_to_emails.rb'
      end
    end
  end
end
