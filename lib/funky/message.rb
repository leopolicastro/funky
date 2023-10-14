module Funky
  class Message
    attr_accessor :role, :content, :name

    def initialize(role, content, name = nil)
      @role = role
      @content = content
      @name = name
    end

    def data
      if name.nil?
        {role: role, content: content}
      else
        # if name if present it's a function
        {role: role, content: content, name: name}
      end
    end
  end
end
