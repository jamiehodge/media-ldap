require_relative "entry"
require_relative "parser"

module Media
  module LDAP
    class Person
      extend Entry

      attr_reader :id, :name, :description, :department,
        :room, :email, :telephone, :updated_at, :parser

      def initialize(entry, options = {})
        @parser = options.fetch(:parser) { Parser }

        @id          = parse(entry["uid"])
        @name        = parse(entry["displayname"])
        @description = parse(entry["title"])
        @department  = parse(entry["departmentnumber"])
        @room        = parse(entry["roomnumber"])
        @email       = parse(entry["mail"])
        @telephone   = parse(entry["telephonenumber"])
        @updated_at  = Date.parse(parse(entry["modifytimestamp"]) || "0000-01-01")
      end

      class << self

        def authenticate(id, password)
          pool.with do |connection|
            entry = connection.bind_as(
              base: base,
              filter: filter(id),
              password: password
            )
            new(entry.first) if entry
          end
        end

        def attributes
          %w(uid displayname title departmentnumber roomnumber mail telephonenumber modifytimestamp)
        end

        def base
          ["ou=people", super].join(",")
        end

        def pk
          "uid"
        end

        def search_attributes
          %w(uid displayname mail)
        end
      end

      def to_h
        {
          id: id,
          name: name,
          description: description,
          department: department,
          room: room,
          email: email,
          telephone: telephone,
          updated_at: updated_at.httpdate
        }
      end

      def parse(value)
        parser.parse(value)
      end
    end
  end
end
