class PoliticianPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

def create?
  user.permissions == "admin"
end

def update?
  user.permissions == "admin"
end

def destroy?
  user.permissions == "admin"
end
  
end
