# frozen_string_literal: true

module Konduto
  module ClassMethods
    def validates_presence_of(*attributes)
      send(:define_method, :required_attr) do
        attributes
      end
    end

    def validates(*attributes, &block)
      if block_given?
        send(:define_method, :custom_validations) do
          { Proc.new(&block) => attributes }
        end
      end
    end
  end
end
