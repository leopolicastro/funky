# frozen_string_literal: true

require "yaml"

module Funky
  module Functions
    class List
      def self.call
        file_path = "#{Funky.functions_path}/list.yml"

        if File.exist?(file_path)
          YAML.load_file(file_path)["functions"]
        else
          raise "No functions file configured or found."
        end
      end
    end
  end
end
