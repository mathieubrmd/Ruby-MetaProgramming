##
#  Mathieu Bourmaud - 19941124-P335
#  Martin Porrès - 19940926-P170
##

require './parser.rb'

module Model
  # Take a filename as argument
  # Based on the content of the file, it will generate a class with attributes and getters/setters
  # It returns an array of the generated class
  def Model.load_from_file(filename)
    return Model.create_class(Parser.get_classname_from_file(filename), Parser.parse_file_data(filename))
  end

  # Generate the class
  def Model.create_class(name, attributes)

    attr_values = attributes[1]
    attr_names = attributes[0]

    objects = []

    # Creating programatically the new class with the name
    newClass = Object.const_set(name, Class.new)

    newClass.class_eval do
      # Setting the attributes
      attr_accessor *attr_names

      # When we'll call the newClass.new with the values
      # It'll assign the values to the attributes
      define_method(:initialize) do | *values |
        attr_names.each_with_index do |name, i|
          instance_variable_set("@"+name, values[i])
        end
      end
    end

    # Now that the class has been created
    # We need to create the X elements and sets the values to the attributes
    i = 0
    while (i < attr_values.length)
      obj = newClass.new(attr_values[i])
      objects.push(obj)
      i = i + 1
    end

    return objects

  end
end

puts Model.load_from_file("toto.txt")
