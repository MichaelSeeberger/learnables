class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    [:admin, :editor, :viewer].each do |role|
      return true if user.has_role? role, record
    end
    false
  end

  def create?
    user.has_role?(:admin) or user.has_role?(:admin, record)
  end

  def new?
    create?
  end

  def update?
    #false
    create? or user.has_role?(:editor, record)
  end

  def edit?
    update?
  end

  def destroy?
    user.has_role? :admin, record
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
