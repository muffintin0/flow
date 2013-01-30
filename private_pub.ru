# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")

PrivatePub.faye_app.bind(:handshake) do |client_id|
  # code to execute
	puts "Client #{client_id} connected"
end

PrivatePub.faye_app.bind(:disconnect) do |client_id|
  # code to execute
	puts "Client #{client_id} disconnected"
end

run PrivatePub.faye_app
