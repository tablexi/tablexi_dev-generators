# frozen_string_literal: true

module TablexiDev

  module Generators

    class UnicornGenerator < Rails::Generators::Base

      source_root File.expand_path("../unicorn_generator/templates", __FILE__)

      def set_variables
        @app_name = Rails.application.class.parent.to_s.underscore
        @production_domain = ask("What is the production domain? (leave blank if you don't know yet)").presence || "[production-domain]"
      end

      def add_files
        template "stage.rb", "config/unicorn/stage.rb"
        template "production.rb", "config/unicorn/production.rb"
      end

      def add_gem
        gem "unicorn", require: false
      end

    end

  end

end
