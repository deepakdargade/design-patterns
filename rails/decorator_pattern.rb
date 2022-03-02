class Car
    def roof
        "fixed"
    end
end

class ConvertibleDecorator < SimpleDelegator
    def roof
        "collapsible"
    end

    def self.decorate(car)
        new(car)
    end

    private

    def model
        __getobj__
    end
end



# And this is how you can use it:

basicCar1 = Car.new()
basicCar2 = Car.new()

basicCar1 = ConvertibleDecorator.decorate(basicCar1)

puts(basicCar1.roof) # => collapsible
puts(basicCar2.roof) # => fixed