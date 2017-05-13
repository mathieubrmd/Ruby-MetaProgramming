module Parser

  # This method takes the filename as argument
  # It returns the class name : From toto.txt to Toto
  def Parser.get_classname_from_file(filename)
    # Removing the file extension
    class_name = filename.split('.').first
    # Capitalize the first letter
    class_name = class_name.capitalize
    # Returning the class name
    return class_name
  end

  # Parsing file data and generating
  def Parser.parse_file_data(filename)
    # Containing the name of the attributes
    attributes = []
    # A 2 dimensions array containing arrays that contains a value for each attribute
    # Ex : [["Matsumoto, Yukihiro", 35], ["van Rossum, Guido", 49], ["Goldberg, Adele", 55]]
    values = []
    i = 0

    # Opening the file and looping through each line
    File.open(filename, "r") do |f|
      f.each_line do |line|
        if i == 0
          attributes = Parser.get_attributes_from_line(line.strip)
        else
          val = Parser.get_values_from_line(line.strip)

          # If the array is empty, we don't push it
          if val.any?
            # If some values were not supposed to be here, we remove them
            # For example if val = [2, 3, 2] and we only have two attributes. We'll remove the third element
            if (val.length > attributes.length)
              val = val.slice(0..attributes.length - 1)
            end

            # Assign the val to the values array
            # It's i - 1 because the attributes array is the first line
            values[i - 1] = val
          end
        end
        i = i + 1
      end
    end

    return [attributes, values]
  end

  # Get the attributes names from the first line of the file
  def Parser.get_attributes_from_line(line)
    attributes = line.split(',')
    return attributes
  end

  # Get the attributes values from the first line of the file
  def Parser.get_values_from_line(line)
    values = Parser.get_tokens(line)
    return values
  end

  # Parse strings inside "" and numbers
  def Parser.get_tokens(line)
    i = 0
    tokens = []
    token = ""
    is_string = false

    # Loop through the string char by char
    while i < line.length
      # If the char is a "
      # We need to know if it's the beginning of a string or the end
      # So to to that, we set is_string to false or true
      # If it's the end of the word, we save the word to the tokens array as a string
      # Otherwise, we save it as a number
      # In both case we reinitialize the token to ""
      if line[i] == "\""
        if is_string == false
          is_string = true
          if !token.to_s.empty?
            tokens.push(token.to_i)
            token = ""
          end

        elsif is_string == true
          is_string = false
          tokens.push(token)
          token = ""
        end
      end

      # If we see a , but we are not in a string
      # It means that we have to push the current token
      # The token is a number and the next is probably one as well
      if line[i] == ","
        if is_string == false
          if !token.to_s.empty?
            tokens.push(token.to_i)
            token = ""
          end
        end
      end

      # We don't want to add to the token the useless char "
      # We also don't want to add the comma in the case that it's a number
      if line[i] != "\""
        if line[i] == ","
          if is_string
            token += line[i]
          end
        else
          token += line[i]
        end
      end

      i = i + 1
    end

    # In the case that we reached the end of the line
    # We save the token
    if !token.to_s.empty? && token != "EOF"
      tokens.push(token.to_i)
    end

    return tokens

  end

end