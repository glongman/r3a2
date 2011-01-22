class ScoresController < ApiBase
  before_filter :find_index_scores, :only => :index
  before_filter :for_player, :only => :create
  def index
    respond_with @scores
  end

  def show
    respond_with @score
  end

  def create
    respond_with Score.create(params[:score])
  end

  def update
    @score.update_attributes params[:player]
    respond_with @score
  end

  def destroy
    respond_with @score.destroy
  end
  
  private
  
  def find_index_scores
    @scores = Score.with_permissions_to(:show)
    @scores = @scores.with(:player_id => params[:player_id]) unless params[:player_id].blank?
  end
  
  def for_user
    if params[:score] && params[:score].is_a?(Hash) && params[:player_id]
      params[:score].merge!(:player_id => params[:player_id])
    end
  end

end

# player_scores GET    /players/:player_id/scores(.:format)          {:controller=>"scores", :action=>"index"}
#               POST   /players/:player_id/scores(.:format)          {:controller=>"scores", :action=>"create"}
#        scores GET    /scores(.:format)                             {:controller=>"scores", :action=>"index"}
#         score GET    /scores/:id(.:format)                         {:controller=>"scores", :action=>"show"}
#               PUT    /scores/:id(.:format)                         {:controller=>"scores", :action=>"update"}
#               DELETE /scores/:id(.:format)                         {:controller=>"scores", :action=>"destroy"}
