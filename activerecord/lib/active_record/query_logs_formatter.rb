# frozen_string_literal: true

module ActiveRecord
  module QueryLogs
    class Formatter # :nodoc:
      attr_reader :key_value_separator

      # @param [String] key_value_separator: indicates the string used for
      # separating keys and values.
      #
      # @param [Symbol] quote_values: indicates how values will be formatted (eg:
      # in single quotes, not quoted at all, etc)
      def initialize(key_value_separator:)
        @key_value_separator = key_value_separator
      end

      # @param [string] value
      # @return [String] The formatted value that will be used in our key-value
      # pairs.
      def format_value(value)
        value
      end
    end

    class QuotingFormatter < Formatter # :nodoc:
      def format_value(value)
        "'#{value.gsub("'", "\\\\'")}'"
      end
    end

    class FormatterFactory # :nodoc:
      # @param [Symbol] formatter: the kind of formatter we're building.
      # @return [Formatter]
      def self.from_symbol(formatter)
        case formatter
        when :default
          Formatter.new(key_value_separator: ":")
        when :sqlcommenter
          QuotingFormatter.new(key_value_separator: "=")
        else
          raise ArgumentError, "Formatter is unsupported: #{formatter}"
        end
      end
    end
  end
end
