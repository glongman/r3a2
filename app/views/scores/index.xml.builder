xml.scores do |xml|
  @scores.each do |u|
    model_xml u, :builder => xml, :skip_instruct => true
  end
end