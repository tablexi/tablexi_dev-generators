# frozen_string_literal: true

module TablexiDev

  module Generators

    class RubocopGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../", __FILE__)

      def copy_files
        copy_file ".rubocop.yml", ".rubocop.yml"
        copy_file ".rubocop-txi.yml", ".rubocop-txi.yml"
      end

      def add_gem
        gem "rubocop", group: :development
      end

    end

  end

end
