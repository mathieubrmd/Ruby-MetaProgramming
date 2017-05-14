##
#  Mathieu Bourmaud - 19941124-P335
#  Martin Porrès - 19940926-P170
##

class Array
  def select_first(attr)
    attr_name = attr.keys[0]
    attr_values = Array(attr.values[0])

    self.each do | x |
      attr_values.each do | val |
        str = "x.#{attr_name} == '#{val}'"

        if eval(str)
          return x
        end
      end
    end

  end
end