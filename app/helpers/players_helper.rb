module PlayersHelper
    
  def player_lock_xml(xml, player = @player)
    xml.lock do
      xml.player player_path(@player, :format => :xml)
      ActiveSupport::XmlMini.to_tag :locked_at, 
          @player.locked_at, 
          :skip_types => true,
          :builder => xml
    end
  end
  
  def player_lock_json(player=@player)
    as_player_lock_json(player).to_json
  end
  
  def as_player_lock_json(player = @player)
    {
      :player => player_path(@player),
      :locked_at => @player.locked_at
    }.as_json
  end
end
