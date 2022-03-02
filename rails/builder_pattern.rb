# This is how your parser classes would look:

class BaseParser
    def initialize(path)
        @path = path
     end
end

class PdfFileParser < BaseParser
    def toString
        # return a string
    end
end

class JpegFileParser < BaseParser
    def toString
         # return a string
    end
end


# And here's how you can create a builder for the final parser object:


class ParserBuilder
    def self.build(path)
        case File.extname(path)
        when '.pdf' then PdfFileParser.new(path)
        when '.jpeg' then JpegFileParser.new(path)
        else
            raise(UnknownFileFormat)
        end
    end
end


# Finally, here’s how you can use this builder:

path = '../../something.ext' # input from user
imageParser = ParserBuilder.build(path)
storage.save(imageParser.toString())