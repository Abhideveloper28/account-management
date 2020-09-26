module Requestor
  def url(path)
    "#{ENV['CUSTOMER_URL']}#{path}"
  end

  def parameters_body
    @parameters || {}
  end

  def json_response
    case @response.code
    when 200
      parse(@response.parsed_response)
    when 401
      {error: "Unauthorized"}
    else
      add_static_errors
      self
    end
  end

  def add_static_errors
    response = @response.parsed_response || []
    response.each do |key, value|
      self.add_static_error(key, value.join(','))
    end
  end

  def header_parameters
    { 'Authorization' => "Bearer #{ENV['ACCESS_TOKEN']}" }
  end

  def request(method_type, url)
    begin
      @response = HTTParty.send(method_type.to_sym, "#{url}", body: parameters_body, headers: header_parameters)
    rescue Exception => e
      puts "GET ERROR: #{url}"
      puts e
      return e.message
    end
    json_response
  end

  def parse(data)
    case data.class.to_s
    when "Hash"
      if self.is_a?(Class)
        klass.new(data)
      else
        self.attributes = data
        self
      end
    when "Array"
      data.map{|attr| klass.new(attr)}
    end
  end

  def klass
    self.is_a?(Class) ? self : self.class
  end

  def path
    '/api/users/'
  end
end
