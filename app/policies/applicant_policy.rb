class ApplicantPolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      scope.all
    end
  end

  attr_reader :current_member, :applicant

  def initialize(current_member,post)
    @user = current_member
    @applicant = post
  end

  def index?
    user.class.eql? Admin or user.class.eql? User
  end


  def create?
    user.class.eql? User
  end


  def show?
    user.class.eql? Admin or user.class.eql? User
  end

  def update?
    user.class.eql? User
  end

  def destroy?
    user.class.eql? User
  end

  def seen?
    user.class.eql? Admin
  end

end
