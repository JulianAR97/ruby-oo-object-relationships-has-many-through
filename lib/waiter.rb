class Waiter
    attr_accessor :name, :yrs_experience
    @@all = []

    def initialize(name, yrs_experience)
        @name = name 
        @yrs_experience = yrs_experience
        @@all << self 
    end 

    def self.all 
        @@all 
    end 

    def new_meal(customer, total, tip=0)
        Meal.new(self, customer, total, tip)
    end 

    def meals
        Meal.all.select {|meal| meal.waiter == self}
    end 

    def best_tipper
        best_tipped_meal = meals.reduce {|a, b| a.tip > b.tip ? a : b}
        best_tipped_meal.customer
    end 

    def most_frequent
        count = {}
        customers = self.meals.map {|meal| meal.customer}
        customers.each do |customer|
            count[customer] ? count[customer] += 1 : count[customer] = 1
        end
        count.collect {|k, v| [k, v]}.reduce {|a1, a2| a1[1] > a2[1] ? a1 : a2}[0]
    end 

    def worst_tip 
        self.meals.reduce {|a, b| a.tip < b.tip ? a : b}
    end 

    def average_tip 
        average = self.meals.map {|meal| meal.tip}.reduce(0,:+).to_f / self.meals.size
        average.round(2)
    end
end