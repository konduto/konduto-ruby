# frozen_string_literal: true

module Konduto
  module Attributes
    def attributes(*attributes)
      attributes.each do |attribute|
        if attribute.is_a? Hash
          klass = attribute.values[0].to_s.gsub(/_/, ' ').split.map(&:capitalize).join('')
          type = Object.const_get(klass)
          name = attribute.keys[0]

          define_strftime_pattern(self, name, attribute[:strftime_pattern]) if attribute.key?(:strftime_pattern)
        else
          name = attribute
        end

        send(:define_method, "#{name}=".to_sym) do |value|
          if !type.nil? && value.is_a?(String)
            value = type.parse(value) if [Date, DateTime].include?(type)
            value = value.to_sym if type == Symbol
          end

          instance_variable_set("@#{name.to_s.gsub(/[?|!]$/, '')}", value)
        end

        send(:define_method, name) do
          instance_variable_get("@#{name.to_s.gsub(/[?|!]$/, '')}") if instance_variable_defined?("@#{name.to_s.gsub(
            /[?|!]$/, ''
          )}")
        end
      end
    end

    alias attribute attributes

    def define_strftime_pattern(klass, name, value)
      klass.send(:define_method, "#{name.to_s.gsub(/[?|!]$/, '')}_strftime_pattern") do
        value
      end
    end
  end
end
