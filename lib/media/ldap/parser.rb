module Media
  module LDAP
    module Parser
      extend self

      def parse(value)
        Array(value).first
      end
    end
  end
end
