# frozen_string_literal: true

module TablexiDev

  module Generators

    class AllGenerator < Rails::Generators::Base

      GENERATORS = %i[
        git_hook
        rubocop
        unicorn
      ].freeze

      def generate_all
        GENERATORS.each { |generator| generate "tablexi_dev:#{generator}" }
      end

    end

  end

end
