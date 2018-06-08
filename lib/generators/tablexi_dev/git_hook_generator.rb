# frozen_string_literal: true

module TablexiDev

  module Generators

    class GitHookGenerator < Rails::Generators::Base

      source_root File.expand_path("../git_hook_generator/files/", __FILE__)

      def copy_files
        maybe_install_rubocop_hook_pre "push"
        maybe_install_rubocop_hook_pre "commit"
      end

      private

      def maybe_install_rubocop_hook_pre(type)
        return unless yes?("Would you like to automatically run rubocop before each 'git #{type}'?")

        # Define pre-hook file paths
        rubocop_path = ".git/hooks/rubocop-pre-#{type}"
        general_path = ".git/hooks/pre-#{type}"

        # Copy files from this generator into the project
        copy_and_set_executable("rubocop-pre-#{type}", rubocop_path)
        copy_and_set_executable("general-pre-#{type}", general_path) unless File.exist?(general_path)

        # Ensure we do not append to the general hook file more than once
        unless File.readlines(general_path).grep(/rubocop-pre-#{type}/).size > 0
          append_to_file(general_path, "exec #{rubocop_path}")
        end
      end

    end

  end

end
