# By default, the following rules apply for access
#
# ┌────────┬───────┬──────┬─────────────┬────────────┬─────────┐
# │  Role  │ index │ show │ update/edit │ new/create │ destroy │
# ├────────┼───────┼──────┼─────────────┼────────────┼─────────┤
# │ admin  │ true  │ true │ true        │ true       │ true    │
# │ editor │ true  │ true │ true        │ false      │ false   │
# │ user   │ true  │ true │ false       │ false      │ false   │
# └────────┴───────┴──────┴─────────────┴────────────┴─────────┘
#
# Subclassing notes:
#   - new? calls create?, so when overriding create? this will change new? as well.
#   - edit? calls update?, so when overriding update? this will change edit? as well.
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user_has_any_role?(:admin, :editor, :user)
  end

  def show?
    user_has_any_role?(:admin, :editor, :user)
  end

  def create?
    user_has_any_role?(:admin)
  end

  def new?
    create?
  end

  def update?
    user_has_any_role?(:admin, :editor)
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

  private

  def user_has_any_role?(*roles)
    roles.each do |role|
      return true if user.has_role?(role, record)
    end

    false
  end
end
