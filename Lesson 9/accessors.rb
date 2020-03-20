# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_name = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        begin
          instance_variable_set(var_name, value)
          instance_variable_get(history_name) << value
        rescue NoMethodError
          instance_variable_set(history_name, [])
          retry
        end
      end
    end
    define_method("#{name}_history") { instance_variable_get(history_name) }
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      unless value.class.to_s == type.to_s
        raise "Type mismatch. Type of the value must be #{type}."
      end

      instance_variable_set(var_name, value)
    end
  end
end
