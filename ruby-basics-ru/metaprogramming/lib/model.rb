# frozen_string_literal: true

# https://github.com/solnic/virtus/blob/master/lib/virtus.rb
# BEGIN
module Model
  module ClassMethods
    attr_reader :scheme

    def attribute(name, options = {})
      @scheme ||= {}
      @scheme[name] = options

      define_method name do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        instance_variable_set "@#{name}", self.class.cast(value, options[:type])
      end
    end

    def cast(value, type)
      return value if type.nil? || value.nil?

      case type
      when :integer
        value.to_i
      when :string
        value.to_s
      when :boolean
        value.to_s == 'true'
      when :datetime
        DateTime.parse(value)
      else
        throw "Unknown type: #{type}"
      end
    end
  end

  # How we can create class methods in different way?
  def self.included(base)
    base.extend ClassMethods
  end

  def attributes
    # Why i can't use @@scheme here?
    self.class.scheme.each_with_object({}) do |(name), acc|
      acc[name] = send name
    end
  end

  def initialize(attributes = {})
    self.class.scheme.each do |name, options|
      value = attributes.key?(name) ? attributes[name] : options.fetch(:default, nil)
      send "#{name}=", value
    end
  end
end
# END
