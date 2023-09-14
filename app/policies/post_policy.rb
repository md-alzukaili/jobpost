class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  attr_reader :current_member, :post

  def initialize(current_member,post)
    @user = current_member
    @post = post
  end

  def index?
    user.class.eql? Admin or user.class.eql? User
  end


  def create?
    user.class.eql? Admin
  end


  def show?
    user.class.eql? Admin or user.class.eql? User
  end

  def update?
    user.class.eql? Admin
  end

  def destroy?
    user.class.eql? Admin
  end
end
