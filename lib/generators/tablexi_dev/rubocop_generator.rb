# frozen_string_literal: true

module TablexiDev

  module Generators

    class RubocopGenerator < Rails::Generators::Base

      source_root File.expand_path("../rubocop_generator/files/", __FILE__)

      def copy_files
        if yes?("Install the .rubocop.yml and .rubocop-txi.yml")
          copy_file "dot_rubocop.yml", ".rubocop.yml"
          copy_file "dot_rubocop-txi.yml", ".rubocop-txi.yml"
        end

        # Create a .rubocop_todo file, which may be generated
        # by the `rubocop --auto-gen-config` command
        create_file ".rubocop_todo.yml" unless File.exist?(".rubocop_todo.yml")

        # Create a file for where individual project-overrides
        # should be stored, and not be clobbered by the txi rules
        unless File.exist?(".rubocop-project_overrides.yml")
          copy_file "dot_rubocop-project_overrides.yml", ".rubocop-project_overrides.yml"
        end

        if yes?("install a pre-commit hook to run rubocop before each 'git commit'?")
          copy_file "rubocop-pre-commit", ".git/hooks/rubocop-pre-commit"
          chmod ".git/hooks/rubocop-pre-commit", 0755

          copy_file "general-pre-commit", ".git/hooks/pre-commit" unless File.exist?(".git/hooks/pre-commit")
          append_to_file(".git/hooks/pre-commit", "exec .git/hooks/rubocop-pre-commit")
        end

        if yes?("install a pre-push hook to run rubocop before each 'git push'?")
          copy_file "rubocop-pre-push", ".git/hooks/rubocop-pre-push"
          chmod ".git/hooks/rubocop-pre-push", 0755

          copy_file "general-pre-push", ".git/hooks/pre-push" unless File.exist?(".git/hooks/pre-push")
          append_to_file(".git/hooks/pre-push", "exec .git/hooks/rubocop-pre-push")
        end
      end

      def add_gem
        # Prevent us from adding the same gem directive multiple times
        # if the Gemfile already has 'rubocop' in a format other
        # than the exact format we expect.
        content = File.read("Gemfile")
        gem "rubocop", group: [:development, :test], require: false unless content.include?("rubocop")
      end

    end

  end

end
