# frozen_string_literal: true

require "cases/helper"

class QueryLogsFormatter < ActiveRecord::TestCase
  def test_factory_invalid_formatter
    assert_raises(ArgumentError) do
      ActiveRecord::QueryLogs::FormatterFactory.from_symbol(:non_existing_formatter)
    end
    end

  def test_factory_invalid_quote_values
    assert_raises(ArgumentError) do
      ActiveRecord::QueryLogs::Formatter.new(key_value_separator: ":", quote_values: :does_not_exist)
    end
  end

  def test_sqlcommenter_key_value_separator
    formatter = ActiveRecord::QueryLogs::FormatterFactory.from_symbol(:sqlcommenter)
    assert_equal("=", formatter.key_value_separator)
  end

  def test_sqlcommenter_quote_value
    formatter = ActiveRecord::QueryLogs::FormatterFactory.from_symbol(:sqlcommenter)
    assert_equal("'Joe\\'s Crab Shack'", formatter.quote_value("Joe's Crab Shack"))
  end
end
