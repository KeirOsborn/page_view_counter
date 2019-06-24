class Parser

  attr_accessor :file, :entries

  def initialize(file)
    if File.exists?(file)
      @file = File.open(file)
      @entries = []
    else
      raise "file does not exist"
    end
  end

  def run
    create_entries
    return_most_page_views_list
    return_most_unique_page_views_list
  end

  def create_entries
    File.open(@file).each_with_index do |line|
      @entries << {page: line.split[0], ip: line.split[1]}
    end
  end

  def return_most_page_views_list
    page_list = []
    @entries.each do |entry|
     page_list << entry[:page]
    end
    puts "\r"
    puts "Pages ordered by most page views:"
    puts page_list.group_by{|e| e}.map {|k,v| [k, v.length]}.sort_by(&:last).reverse
  end

  def return_most_unique_page_views_list
    page_list = []
    @entries.uniq.each do |entry|
      page_list << entry[:page]
    end
    puts "\r"
    puts "Pages ordered by most unique page views:"
    puts page_list.group_by{|e| e}.map {|k,v| [k, v.length]}.sort_by(&:last).reverse
  end

end

parser = Parser.new(ARGV[0])

parser.run