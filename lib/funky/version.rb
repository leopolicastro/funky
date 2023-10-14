# frozen_string_literal: true

require "openai"

require_relative "history"
require_relative "message"
require_relative "client"
require_relative "functions/index"

module Funky
  VERSION = "0.1.0"
end
