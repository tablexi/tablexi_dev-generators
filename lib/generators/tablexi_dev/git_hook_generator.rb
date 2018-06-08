# frozen_string_literal: true

module TablexiDev

  module Generators

    class GitHookGenerator < Rails::Generators::Base

      source_root File.expand_path("../git_hook_generator/files/", __FILE__)

      def copy_files
        install_pre_commit_hook
        install_pre_push_hook
      end

      private

      def install_pre_commit_hook
        return unless yes?("Would you like to automatically run rubocop before each 'git commit'?")

        copy_file "rubocop-pre-commit", ".git/hooks/rubocop-pre-commit"
        chmod ".git/hooks/rubocop-pre-commit", 0o755
        copy_and_set_executable("general-pre-commit", ".git/hooks/pre-commit") unless File.exist?(".git/hooks/pre-commit") # rubocop:disable Metrics/LineLength
        append_to_file(".git/hooks/pre-commit", "exec .git/hooks/rubocop-pre-commit")
      end

      def install_pre_push_hook
        return unless yes?("Would you like to automatically run rubocop before each 'git push'?")

        copy_and_set_executable("rubocop-pre-push", ".git/hooks/rubocop-pre-push")
        copy_and_set_executable("general-pre-push", ".git/hooks/pre-push") unless File.exist?(".git/hooks/pre-push")
        append_to_file(".git/hooks/pre-push", "exec .git/hooks/rubocop-pre-push")
      end

    end

  end

end
