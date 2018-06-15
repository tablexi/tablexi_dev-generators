# frozen_string_literal: true

module TablexiDev

  module Generators

    # All other TablexiDev generators should inherit this base generator
    class BaseGenerator < Rails::Generators::Base

      protected

      def copy_file_and_set_executable(source_file, target_file)
        copy_file source_file, target_file
        chmod target_file, 0o755
      end

    end

  end

end
