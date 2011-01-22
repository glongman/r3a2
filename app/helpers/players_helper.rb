module PlayersHelper
  def lock_xml(xml, player = @player)
    xml.lock do
      xml.user player_url(@player)
      ActiveSupport::XmlMini.to_tag :locked_at, 
          @player.locked_at, 
          :skip_types => true,
          :builder => xml
    end
  end
  
  def lock_json(player = @player)
    {
      :user => player_path(@player),
      :locked_at => @player.locked_at
    }.to_json
  end
end
