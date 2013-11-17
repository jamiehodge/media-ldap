require_relative "entry"
require_relative "parser"

module Media
  module LDAP
    class Group
      extend Entry

      attr_reader :id, :name, :updated_at, :parser

      def initialize(entry, options = {})
        @parser = options.fetch(:parser) { Parser }

        @id          = parse(entry["cn"])
        @name        = parse(entry["description"])
        @updated_at  = Date.parse(parse(entry["modifytimestamp"]) || "0000-01-01")
      end

      class << self

        def attributes
          %w(cn description modifytimestamp)
        end

        def base
          ["ou=group", super].join(",")
        end

        def pk
          "cn"
        end

        def search_attributes
          %w(cn description)
        end
      end

      def to_h
        {
          id: id,
          name: name,
          updated_at: updated_at.httpdate,
          person_ids: person_ids
        }
      end

      def parse(value)
        parser.parse(value)
      end
    end
  end
end
