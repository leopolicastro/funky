module Funky
  class History
    attr_accessor :messages

    def initialize
      @messages = []
    end

    def chronicle(role, prompt, name = nil)
      messages << Message.new(role, prompt, name).data
    end
  end
end
