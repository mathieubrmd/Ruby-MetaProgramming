##
#  This file contains unittests for the DYPL Ruby code generation
#  assignment. All assigments handed in must pass these tests or
#  be failed.
#
##

require 'test/unit'

##------------------------------------------------------------------------------

class Array
  def dd(other)
    return false unless other.kind_of? Array
    return false unless other.size == self.size
    return self.all? { |e| other.include?( e ) }
  end
end

class TestPerson
  attr_accessor :name, :age
  def initialize(name, age)
    @name, @age = name, age
  end
  def <=>(other); @age <=> other.age; end
  def inspect
    "#{@name}(#{@age})"
  end
end

##-----------------------------------------------------------------------------

PERSON_SOURCE = <<EOF
name,age
"Matsumoto, Yukihiro", 35
"van Rossum, Guido", 49
"Goldberg, Adele", 55
"Kay, Alan", 19, 157
"Wall, Larry", 23
EOF

##-----------------------------------------------------------------------------

class GeneratorTest < Test::Unit::TestCase
  
    # Create the input files
    File::open("personage.txt", "w") { |f| f << PERSON_SOURCE }
    
    # Load the code generation lib
    load 'code_generation.rb'

    # Create a class from personage.txt
    @@list_of_objects = Model.load_from_file( './personage.txt' ) 
     
  def setup
    File::open("personage.txt", "w") { |f| f << PERSON_SOURCE }

    @list_of_objects = @@list_of_objects
  
    assert_not_equal( nil, @list_of_objects, "Model::load_from_file returned nil")

    # Make sure the correct number of elements were loaded
    assert_equal( 5, @list_of_objects.size, "Wrong number of elements loaded")
  end
  
  def teardown
    # Delete input files
    File::delete("personage.txt")
  end
  
  def test_cheating_misunderstanding
    assert_raise NameError do
      Object::Person
    end
    ["code_generation.rb"].each do |fn|
      File::open(fn, "r") do |f|
	assert_equal( false, f.readlines.any? {|l| l =~ /personclass/ }, "Looks like you've looked to closely at the unit test suite!")
      end
    end
  end
  
end

class ArrayTest < Test::Unit::TestCase
  def setup
    load 'array_extension.rb'
    puts "loading"
    @johan = TestPerson.new('Johan', 26)
    @tobias = TestPerson.new('Tobias', 29)
    @beatrice = TestPerson.new('Beatrice', 32)
    @tobias_again = TestPerson.new('Tobias', -29)
    @array = [@johan, @tobias, @beatrice, @tobias_again]  
  end
  
  def teardown
  end

  def test_select_first
    assert_equal( @tobias, @array.select_first( :name => 'Tobias' ) )
    assert_equal( @johan, @array.select_first( :name => ['Tobias', 'Johan'] ) )
  end

end
