module Presenter
  class Base < SimpleDelegator
    
    def initialize(object, view_context)
      @object, @view_context = object, view_context
      super(@object)
    end

    private

    attr_reader :view_context

    def self.presents(name)
      define_method(name) do
        @object
      end
    end
  end
end
