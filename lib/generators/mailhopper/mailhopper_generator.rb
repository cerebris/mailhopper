require 'rails/generators'
require 'rails/generators/migration'

module Mailhopper
  module Generators
    class MailhopperGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Generates Mailhopper files.'

      def self.source_root
        File.join(File.dirname(__FILE__), 'templates')
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def create_migration_file
        migration_template 'migrations/create_emails.rb', 'db/migrate/create_emails.rb'
      end

      def copy_initializer
        template 'initializer.rb', 'config/initializers/mailhopper.rb'
      end

      def show_readme
        readme 'README' if behavior == :invoke
      end
    end
  end
end
