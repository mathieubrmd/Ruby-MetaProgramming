##
#  Mathieu Bourmaud - 19941124-P335
##

class Array
  def select_first(attr)
    attr_name = attr.keys[0]
    attr_values = attr.values[0]

    self.each do | x |
      if eval("x.#{attr_name} == '#{attr_values}'")
        return x
      end
    end

  end
end