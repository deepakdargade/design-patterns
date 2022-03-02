# To understand the use of the Value pattern, first, let’s take a look at the following piece of code:

class EmailHandler
    def initialize(emails)
        @emails = emails
    end
    
    def get_data
        emails.map { |email| {
                name: email.match(/([^@]*)/).to_s,
                domain: email.split("@").last
            }
        }
    end
    
    private
    attr_reader :emails
end

puts EmailHandler.new(["abc@xyz.com", "abd@xyx.cd"]).get_data
# => {:name=>"abc", :domain=>"xyz.com"}
# => {:name=>"abd", :domain=>"xyx.cd"}




# This is how you can simplify it by using the Value design pattern:
class EmailValues
    def initialize(email)
        @email = email
    end
    
    def name
        email.match(/([^@]*)/).to_s
    end
    
    def domain
        email.split("@").last
    end
    
    def to_h
        { name: name, domain: domain }
    end
    
    private
    attr_reader :email
end


# And use the Value object in the handler class:

class EmailHandler
    def initialize(emails)
        @emails = emails
    end
    
    def get_data
        emails.map { |email| EmailValues.new(email).to_h }
    end
    
    private
    attr_reader :emails
end

puts EmailHandler.new(["abc@xyz.com", "abd@xyx.cd"]).get_data
# => {:name=>"abc", :domain=>"xyz.com"}
# => {:name=>"abd", :domain=>"xyx.cd"}

