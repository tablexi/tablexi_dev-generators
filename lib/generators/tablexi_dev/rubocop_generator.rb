# frozen_string_literal: true

module TablexiDev

  module Generators

    class RubocopGenerator < Rails::Generators::Base

      source_root File.expand_path("../rubocop_generator/files/", __FILE__)

      def copy_files
        install_rubocop_config_files

        install_pre_commit_hook
        install_pre_push_hook
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
        if yes?("Install the .rubocop.yml and .rubocop-txi.yml")
          copy_file "dot_rubocop.yml", ".rubocop.yml"
          copy_file "dot_rubocop-txi.yml", ".rubocop-txi.yml"
        end

        # Create a .rubocop_todo file, which may be generated
        # by the `rubocop --auto-gen-config` command
        create_file ".rubocop_todo.yml" unless File.exist?(".rubocop_todo.yml")

        # Create a file for where individual project-overrides
        # should be stored, and not be clobbered by the txi rules
        unless File.exist?(".rubocop-project_overrides.yml") # rubocop:disable Style/GuardClause
          copy_file "dot_rubocop-project_overrides.yml", ".rubocop-project_overrides.yml"
        end
      end

      def install_pre_commit_hook
        return unless yes?("install a pre-commit hook to run rubocop before each 'git commit'?")

        copy_file "rubocop-pre-commit", ".git/hooks/rubocop-pre-commit"
        chmod ".git/hooks/rubocop-pre-commit", 0o755

        copy_and_set_executable("general-pre-commit", ".git/hooks/pre-commit") unless File.exist?(".git/hooks/pre-commit") # rubocop:disable Metrics/LineLength
        append_to_file(".git/hooks/pre-commit", "exec .git/hooks/rubocop-pre-commit")
      end

      def install_pre_push_hook
        return unless yes?("install a pre-push hook to run rubocop before each 'git push'?")

        copy_and_set_executable("rubocop-pre-push", ".git/hooks/rubocop-pre-push")

        copy_and_set_executable("general-pre-push", ".git/hooks/pre-push") unless File.exist?(".git/hooks/pre-push")
        append_to_file(".git/hooks/pre-push", "exec .git/hooks/rubocop-pre-push")
      end

      def copy_and_set_executable(source_file, target_file)
        copy_file source_file, target_file
        chmod target_file, 0o755
      end

    end

  end

end
