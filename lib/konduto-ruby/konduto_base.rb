# frozen_string_literal: true

require_relative 'associations/associations'
require_relative 'validations/validations'
require_relative 'attributes'

class KondutoBase
  extend Konduto::Associations
  extend Konduto::Attributes
  include Konduto::Validations

  def initialize(*args)
    args[0]&.each do |key, value|
      unless value.nil?
        if respond_to? "#{key}=".to_sym
          send("#{key}=", value)
        elsif key == 'class'
          send('klass=', value)
        else
          instance_variable_set("@#{key}", value)
        end
      end
    end
  end

  def to_hash
    Hash[
      instance_variables.map do |name|
        value = instance_variable_get(name)

        strftime_pattern = defined_strftime_pattern(name) if defined_strftime_pattern?(name)

        if value.respond_to? :each
          value = value.map(&:to_hash)
        elsif !value.instance_variables.empty?
          value = value.to_hash
        elsif value.is_a?(DateTime)
          value = value.strftime(strftime_pattern || '%Y-%m-%dT%H:%MZ')
        elsif value.is_a?(Date)
          value = value.strftime(strftime_pattern || '%Y-%m-%d')
        elsif value.is_a?(Symbol)
          value = value.to_s
        end

        [name == :@klass ? 'class' : name.to_s.gsub(/^@/, ''), value]
      end
    ]
  end

  def to_json(*_args)
    raise 'Invalid object for serialization' unless valid?

    to_hash.to_json
  end

  def ==(other)
    instance_variables.each do |name|
      return false unless instance_variable_get(name) == other.instance_variable_get(name)
    end

    true
  end

  def defined_strftime_pattern?(attr)
    respond_to? "#{attr.to_s.gsub(/^@/, '')}_strftime_pattern"
  end

  def defined_strftime_pattern(attr)
    send("#{attr.to_s.gsub(/^@/, '')}_strftime_pattern")
  end
end
