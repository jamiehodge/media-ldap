require "net/ldap"

module Media
  module LDAP
    class Filter

      attr_reader :filterer

      def initialize(options = {})
        @filterer = options.fetch(:filterer) { Net::LDAP::Filter }
      end

      def filter(attributes, values)
        attributes = attributes
        values     = values.split.map(&:chomp)

        values.map {|value|
          attributes.map {|attribute|
            filterer.begins(attribute, value)
          }.inject(&:|)
        }.inject(&:&)
      end
    end
  end
end
