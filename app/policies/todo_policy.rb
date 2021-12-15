class TodoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    record.user == user
  end
  
  def check?
    record.user == user
  end
  
  def up?
    record.user == user
  end
  
  def down?
    record.user == user
  end
end
