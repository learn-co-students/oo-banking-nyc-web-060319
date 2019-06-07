require "pry"
class BankAccount

    attr_accessor :status, :balance
    attr_reader :name

    def initialize(name, balance = 1000, status = "open")
        @name = name
        @balance = balance
        @status = status
    end

    def deposit(balance)
        @balance += balance
    end

    def display_balance
         "Your balance is $#{@balance}."
    end

    def valid?
        if @balance>0 && @status == "open"
            return true
        else
            return false
        end
    end

    def close_account
        @status = "closed"
    end

end
