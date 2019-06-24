require_relative '../spec_helper'

Dir[File.join(".", "**/*.rb")].each do |f|
  require f
end

RSpec.describe Parser do

  describe 'initializing the script with a non-existent file' do

    it 'raises an error' do
      expect { described_class.new('webserverasd.log') }.to raise_error(RuntimeError)
    end
  end

  describe 'initializing the script with the correct file' do

    it 'returns and object with a file and an empty array of entries' do
      expect( described_class.new('webserver.log') ).to be_kind_of(Parser)
    end
  end

  describe 'running the script' do
    stdout = StringIO.new
    $stdout = stdout
    parser = Parser.new('webserver.log')
    parser.run

    it 'orders pages by most views and lists views per page' do
      expect( $stdout.string ).to include("Pages ordered by most page views:")
      expect( $stdout.string ).to include("/about/2\n90")
      expect( $stdout.string ).to include("/contact\n89")
      expect( $stdout.string ).to include("/index\n82")
      expect( $stdout.string ).to include("/about\n81")
    end

    it 'orders pages by most unique views and lists unique views per page' do
      expect( $stdout.string ).to include("Pages ordered by most unique page views:")
      expect( $stdout.string ).to include("/about/2\n22")
      expect( $stdout.string ).to include("/contact\n23")
      expect( $stdout.string ).to include("/index\n23")
      expect( $stdout.string ).to include("/about\n21")
    end
  end
end
