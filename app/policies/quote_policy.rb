require 'byebug'

class QuotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      # scope.where(creator: user)
    end
  end

  def create? 
    user
  end

  def update? 
    record.creator == user || (user.permissions == ("admin" || "moderator"))
      # - record: the quote passed to the `authorize` method in controller 
      # - user:   the `current_user` signed in with Devise. 
  end 

  def destroy? 
    user.permissions == ("admin" || "moderator")
  end
end
