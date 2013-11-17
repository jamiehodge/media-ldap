require_relative "pool"
require_relative "filter"

module Media
  module LDAP
    module Entry

      def [](id)
        search(id).first
      end

      def search(query)
        return [] if query.to_s.empty?

        pool.with do |connection|

          connection.search(
            base: base,
            filter: filter(query),
            attributes: attributes
          ).map {|entry| new(entry) }
        end
      rescue Timeout::Error
        []
      end

      private

      def base
        ENV["LDAP_BASE"]
      end

      def pool
        @pool ||= Pool
      end

      def filter(query)
        filterer.filter(search_attributes, query)
      end

      def filterer
        @filterer ||= Filter.new
      end

      attr_writer :filterer
    end
  end
end
