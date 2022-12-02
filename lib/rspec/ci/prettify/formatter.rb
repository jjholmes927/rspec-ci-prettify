require 'rspec/core'
require 'rspec/core/formatters/base_formatter'

module RSpec
  module Ci
    module Prettify
        class Formatter < RSpec::Core::Formatters::BaseFormatter
            RSpec::Core::Formatters.register self, :dump_summary,

            def dump_summary(notification)
                @output << "\n\nFinished in #{RSpec::Core::Formatters::Helpers.format_duration(notification.duration)}."
            end

            def close(notification)
                @output << "\n"
            end
        end
    end
  end
end