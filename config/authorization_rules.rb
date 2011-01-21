authorization do
  role :admin do
    has_permission_on :users , :to => :manage
    has_permission_on :users do
      to :manage_locks
      if_attribute :role => is_not {'admin'}
    end
  end
  role :api do
    has_permission_on :users do
      to :manage
      if_attribute :role => is_not_in {%w(admin api)}
    end
  end
  role :normal do
    includes :self_service
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
    includes :create, :show, :update, :delete
  end
  privilege :manage_locks do
    includes :lock, :unlock, :show_lock
  end
end