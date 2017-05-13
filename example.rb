file_name = "./toto.txt"

class DataRecord

  def self.make(file_name)
    data = File.new(file_name)
    names = data.gets.chomp.split(',')
    data.close

    class_name = File.basename(file_name, ".txt").capitalize
    my_class = Object.const_set(class_name, Class.new)
    
    my_class.class_eval do 
      attr_accessor *names

      define_method(:initialize) do | *values |
        names.each_with_index do |name, i|
          instance_variable_set("@"+name, values[i])
        end
      end      

      define_method(:to_s) do
        str = "<#{self.class}:"
        names.each { | name |  str << "#{name} = #{self.send(name)},"}
        str + ">"
      end
    end
    
    def my_class.read 
      all = []
      
      file = File.open(self.to_s.downcase + ".txt")
      file.gets
      
      file.each do | line |
        line.chomp!
        if (line != "EOF")
          values = eval("[#{line}]")
          all << self.new(*values)
        end
      end
      
      file.close
      all
    end

    my_class
  end

end

the_class =  DataRecord.make("./toto.txt")

all_objects = the_class.read

puts all_objects

#the_person = p.new
#the_person.name = "Matz"
#puts the_person.name
