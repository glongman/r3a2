class PlayersController < ApiBase
  before_filter :find_index_players, :only => :index
  before_filter :for_user, :only => :create
  filter_resource_access
  filter_access_to [:show_lock, :lock, :unlock], :attribute_check => true
  def index
    respond_with @players
  end

  def create
    respond_with Player.create(params[:player])
  end

  def update
    @player.update_attributes params[:player]
    respond_with @player
  end

  def destroy
    respond_with @player.destroy
  end
  
  def show_lock
    respond_with @player
  end
  
  def unlock
    @player.unlock_access!
    respond_with @player
  end
  
  def lock
    @player.lock_access!
    respond_with @player
  end
  
  private
  
  def find_index_players
    @players = Player.with_permissions_to(:show)
    @players = @players.with(:user_id => params[:user_id]) unless params[:user_id].blank?
  end
  
  def for_user
    if params[:player] && params[:player].is_a?(Hash) && params[:user_id]
      params[:player].merge!(:user_id => params[:user_id])
    end
  end
  
end

#    user_players GET    /users/:user_id/players(.:format)             {:controller=>"players", :action=>"index"}
#                 POST   /users/:user_id/players(.:format)             {:controller=>"players", :action=>"create"}
#     lock_player GET    /players/:id/lock(.:format)                   {:controller=>"players", :action=>"show_lock"}
#                 PUT    /players/:id/lock(.:format)                   {:controller=>"players", :action=>"lock"}
#                 DELETE /players/:id/lock(.:format)                   {:controller=>"players", :action=>"unlock"}
#         players GET    /players(.:format)                            {:controller=>"players", :action=>"index"}
#                 POST   /players(.:format)                            {:controller=>"players", :action=>"create"}
#          player GET    /players/:id(.:format)                        {:controller=>"players", :action=>"show"}
#                 PUT    /players/:id(.:format)                        {:controller=>"players", :action=>"update"}
#                 DELETE /players/:id(.:format)                        {:controller=>"players", :action=>"destroy"}
