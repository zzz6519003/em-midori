require 'eventmachine'

module Midori
  def self.run(api = Midori::API, ip = nil, port = nil)
    ip ||= '127.0.0.1'
    port ||= 8081
    EventMachine.run do
      puts "Midori #{Midori::VERSION} is now running on #{ip}:#{port}".blue
      @midori_server = EventMachine.start_server ip, port, Midori::Server, api
    end
  end

  def self.stop
    if @midori_server.nil?
      puts 'Midori Server has NOT been started'.red
      return false
    else
      EventMachine.stop_server(@midori_server)
      @midori_server = nil
      puts 'Goodbye Midori'.blue
      return true
    end
  end
end
