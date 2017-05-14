##
#  Mathieu Bourmaud - 19941124-P335
##

class Array
  def select_first(attr)

    attr_name = attr.keys[0]
    
    self.each do | x |
      attr.values.each do | val |
        if eval("x.#{attr_name} == '#{val}'")
          p x
          return x
        end
      end
    end

  end
end