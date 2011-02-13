module ApplicationHelper
  
  # return a json string for a record or collection records
  def model_json(records, options={}, &block)
    if records.respond_to?(:each)
      records.inject([]) do |result, record|
        result << as_model_json(record, options, &block)
        result
      end.to_json
    else
      as_model_json(records, options, &block).to_json
    end
  end
  
  # make a hash of a single record for use as json
  def as_model_json(record, options={}, &block)
    json = record.as_json(options)
    url = record_url(record)
    json.merge!('url' => url) if url
    yield json if block_given?
    json
  end
  
  # make xml for a single record that includes the url for the record
  def model_xml(record, options={}, &block)
    chain_proc = Proc.new do |xml| 
      url = record_url(record)
      xml.url url unless record.new_record?
      block.call(xml) if block
    end
    record.to_xml(
      options.merge(:skip_types => true),
      &chain_proc)
  end
  
  def record_url(record)
    send(:"#{record.class.name.downcase}_path", record) unless record.new_record?
  end
end
