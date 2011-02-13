xml.players do |xml|
  @players.each do |u|
    model_xml u, :builder => xml, :skip_instruct => true
  end
end