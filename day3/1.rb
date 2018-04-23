# Modify the example CSV application from the book.
# Add an each method which iterates over CsvRow objects.
# Use method_missing on CsvRow so that each value can be accessed via its heading.

class CsvRow
  attr_accessor :headers, :pairs

  def initialize(headers, values)
    @headers = headers

    # a pairs hash which relates each heading to its value
    @pairs = headers.each_with_index.reduce({}) do |pairs, (header, index)|
      pairs[header] = values[index]
      pairs
    end
  end

  def method_missing(name, *args)
    # for any missing method names lookup a value from the pairs hash
    @pairs[name.to_s]
  end
end

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    attr_accessor :headers, :csv_rows
    
    def initialize
      read
    end

    def read
      filename = self.class.to_s.downcase + '.txt'
      file_path = File.join(File.dirname(__FILE__), "./#{filename}")
      file = File.new(file_path)

      @headers = file.gets.chomp.split(', ')
      @csv_rows = file.map { |row| CsvRow.new(@headers, row.chomp.split(', ')) }
    end

    def each(&block)
      @csv_rows.each(&block)
    end
  end
end

class Csv
  include ActsAsCsv
  acts_as_csv
end

sample = Csv.new

puts "Heading 'one'"
sample.each { |row| puts row.one }
puts ""

puts "Heading 'two'"
sample.each { |row| puts row.two }
puts ""

puts "Heading 'three'"
sample.each { |row| puts row.three }
puts ""
