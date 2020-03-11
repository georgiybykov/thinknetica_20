# class Foo
#   def initialize
#     @bar = 'instance var'
#   end

#   private

#   def private_method
#     puts "I'm a private method"
#   end
# end

module MyAttrAccessor
  def my_attr_accessor(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end
end

class Test
  extend MyAttrAccessor

  my_attr_accessor :my_attr, :a, :b, :q, :someone
end

# class Module
#   def attr_accessor(*methods)
#     methods.each do |method|
#       raise TypeError.new('method is not a symbol') unless method.is_a?(Symbol)
#       define_method(method) do
#         instance_variable_get("@#{method}")
#       end
#       define_method("@#{method}=") do |v|
#         instance_variable_set("@#{method}", v)
#       end
#     end
#   end
# end
