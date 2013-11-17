require "connection_pool"
require "net/ldap"

require_relative "extension"

module Media
  module LDAP
    Pool ||= ConnectionPool.new(size: 15) do
      Net::LDAP.new(host: ENV["LDAP_HOST"], port: ENV["LDAP_PORT"], encryption: :start_tls)
    end
  end
end
