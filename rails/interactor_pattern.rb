class ManageStocks
    include Interactor
    
    def call
        # retrieve and update stocks here
    end
end

class DispatchShipment
    include Interactor
    
    def call
        # order the dispatch of the goods here
    end
end

class ScheduleMail
    include Interactor

    def call
        # send an email to the recipient here
    end
end

class MakeSale
    include Interactor::Organizer

    organize ManageStocks, DispatchShipment, ScheduleMail
end

# Here’s how you can perform a transaction:

result = MakeSale.call(
    recipient: user, products: products
)

puts outcome.success?
puts outcome.message