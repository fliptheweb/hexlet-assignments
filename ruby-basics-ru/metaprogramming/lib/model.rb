# frozen_string_literal: true

# https://github.com/solnic/virtus/blob/master/lib/virtus.rb
# BEGIN
module Model
  # How we can create class methods in different way?
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :scheme

    def attribute(name, options = {})
      @scheme ||= {}
      @scheme[name] = options

      define_method name do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        instance_variable_set "@#{name}", cast(value, options[:type])
      end
    end
  end

  def attributes
    # Why i can't use @@scheme here?
    self.class.scheme.each_with_object({}) do |(name), acc|
      acc[name] = send name
    end
  end

  def initialize(attributes = {})
    self.class.scheme.each do |name, options|
      value = attributes.key?(name) ? attributes[name] : options[:default]
      send "#{name}=", value
    end
  end

  private

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
      value
    end
  end
end
# END
