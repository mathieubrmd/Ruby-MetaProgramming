##
#  Mathieu Bourmaud - 19941124-P335
#  Martin Porrès - 19940926-P170
##

module Model

  # Take a filename as argument
  # Based on the content of the file, it will generate a class with attributes and getters/setters
  # It returns an array of the generated class
  def Model.load_from_file(filename)
    Model.create_class(Model.get_classname_from_file(filename))
  end

  # Generate the class
  def Model.create_class(name)
    printf("%s\n", name)
  end

  # This method takes the filename as argument
  # It returns the class name : From toto.txt to Toto
  def Model.get_classname_from_file(filename)

    class_name = filename.split('.').first
    class_name = class_name.capitalize

    return class_name
  end

end


Model.load_from_file("toto.txt")
