module Media
  module LDAP
    module Parser
      extend self

      def parse(value)
        result = Array(value).first
        result.force_encoding("UTF-8") if result
      end
    end
  end
end
