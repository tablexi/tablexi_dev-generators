# frozen_string_literal: true

module TablexiDev

  module Generators

    class RubocopGenerator < BaseGenerator

      source_root File.expand_path("../rubocop_generator/files/", __FILE__)

      def copy_files
        install_rubocop_config_files
      end

      def add_gem
        # Prevent us from adding the same gem directive multiple times
        # if the Gemfile already has 'rubocop' in a format other
        # than the exact format we expect.
        content = File.read("Gemfile")
        gem "rubocop", group: %i[development test], require: false unless content.include?("rubocop")
      end

      private

      def install_rubocop_config_files
        copy_file "dot_rubocop.yml", ".rubocop.yml"
        copy_file "dot_rubocop-txi.yml", ".rubocop-txi.yml"

        # Create a .rubocop_todo file, which may be generated
        # by the `rubocop --auto-gen-config` command
        create_file ".rubocop_todo.yml" unless File.exist?(".rubocop_todo.yml")

        # Create a file for where individual project-overrides
        # should be stored, and not be clobbered by the txi rules
        unless File.exist?(".rubocop-project_overrides.yml") # rubocop:disable Style/GuardClause
          copy_file "dot_rubocop-project_overrides.yml", ".rubocop-project_overrides.yml"
        end
      end

    end

  end

end
