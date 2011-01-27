authorization do
  role :admin do
    has_permission_on :users , :to => [:new, :update, :edit, :index, :show]
    has_permission_on :users do
      to :create
      if_attribute :role => is_not {'admin'}
    end
    has_permission_on :users do
      to :destroy
      if_attribute :role => is_not {'admin'}
    end
    has_permission_on :users do
      to :show_lock
    end
    has_permission_on :users do
      to :manage_locks
      if_attribute :role => is_not {'admin'}
    end
    has_permission_on :players, :to => :manage
    has_permission_on :scores, :to => :manage
    has_permission_on :scoresheets, :to => :manage
  end
  role :api do
    includes :self_service
    has_permission_on :users do
      to :manage
      if_attribute :role => is_not_in {%w(admin api)}
    end
    has_permission_on :users, :to => :show_lock
    has_permission_on :players, :to => :manage
    has_permission_on :scores, :to => :manage
    has_permission_on :scoresheets, :to => :manage
  end
  role :normal do
    includes :self_service
    has_permission_on :players, :to => :manage
    has_permission_on :scores, :to => :manage do
      if_attribute :player => {:user => is {user.id}}
    end
    has_permission_on :scoresheets, :to => [:index, :show, :update] do
      if_attribute :player => {:user => is {user.id}}
    end
  end
  role :guest do
  end
  # roles below here are intended to be included in the roles above
  role :self_service do 
    has_permission_on :users do
      to [:edit, :update]
      if_attribute :id => is {user.id}
    end
  end
end

privileges do
  privilege :manage do
    includes :crud, :index, :edit, :new
  end
  privilege :crud do
    includes :create, :show, :update, :destroy
  end
  privilege :manage_locks do
    includes :lock, :unlock, :show_lock
  end
end