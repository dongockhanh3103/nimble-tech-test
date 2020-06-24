# frozen_string_literal: true

module UserOperation
  class CreateUser < BaseOperation

    def initialize(email)
      @email = email
    end

    def execute
      if(User.exists?(email: @email))
        return User.find(email: @email)
      end

      User.create!(email: @email)
    rescue ActiveRecord::ActiveRecordError => exeception
      # TODO: Need to handle exception here
    end

  end
end