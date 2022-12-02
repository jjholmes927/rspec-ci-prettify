# frozen_string_literal: true

require 'rspec/core'
require 'rspec/core/formatters/base_formatter'
require 'rspec/core/formatters/console_codes'
require_relative 'constants'

module RSpec
  module Ci
    module Prettify
      class Formatter < RSpec::Core::Formatters::BaseFormatter
        RSpec::Core::Formatters.register self, :dump_summary, :dump_pending, :dump_failures,
                                         :example_passed, :example_failed, :example_pending, :close

        def initialize(output)
          @output = output
        end

        def dump_summary(summary)
          @output << RSpec::Ci::Prettify::Constants::SEPARATOR
          @output << format_colour("\n\nSUMMARY:\n\t", :cyan)

          build_summary(summary)
        end

        def dump_pending(notification)
          @output << RSpec::Ci::Prettify::Constants::SEPARATOR
          @output << format_colour("\n\nPENDING:\n\t", :pending)

          @output << notification.pending_examples.map do |example|
            format_colour(format_example_summary(example), :pending)
          end.join("\n\t")
        end

        def dump_failures(notification)
          @output << RSpec::Ci::Prettify::Constants::SEPARATOR
          @output << format_colour("\n\nFAILURES:\n\t", :failure)
          @output << failed_examples_output(notification)
        end

        def example_passed(example)
          # @output << RSpec::Core::Formatters::ConsoleCodes.wrap(".", :success)
        end

        def example_failed(example)
          # @output << RSpec::Core::Formatters::ConsoleCodes.wrap("F", :failure)
        end

        def example_pending(example)
          # @output << RSpec::Core::Formatters::ConsoleCodes.wrap("*", :pending)
        end

        def close(_notification)
          @output << "\n"
        end

        private

        def build_summary(summary)
          total_test_count = summary.examples.count
          pending_count = summary.pending_examples.count
          total_tests_ran = total_test_count - pending_count

          failure_count = summary.failed_examples.count
          pass_count = total_tests_ran - failure_count

          @output << build_test_suite_duration(summary, total_tests_ran)
          @output << build_pending_summary(pending_count, total_test_count)

          if pass_count == total_tests_ran
            @output << format_colour("\n All #{total_tests_ran} tests ran passed!!!", :magenta)
            return
          end

          @output << build_failure_summary(failure_count, total_tests_ran)
          @output << build_pass_summary(pass_count, total_tests_ran)
        end

        def build_test_suite_duration(summary, test_run_count)
          duration = RSpec::Core::Formatters::Helpers.format_duration(summary.duration)
          duration_text = "\nRan #{test_run_count} tests overall in #{duration}."

          format_colour(duration_text, :cyan)
        end

        def build_pending_summary(pending_count, total_test_count)
          pending_percentage = percentage_of_examples(pending_count, total_test_count)
          pending_summary = "\n #{pending_percentage} of tests skipped/pending (#{pending_count})"
          indent(format_colour(pending_summary, :pending), 4)
        end

        def build_failure_summary(failure_count, total_tests_ran)
          failure_percentage = percentage_of_examples(failure_count, total_tests_ran)
          failure_summary = "\n #{failure_percentage} of tests failed (#{failure_count})"
          indent(format_colour(failure_summary, :failure), 4)
        end

        def build_pass_summary(pass_count, total_tests_ran)
          pass_percentage = percentage_of_examples(pass_count, total_tests_ran)

          pass_summary = "\n #{pass_percentage} of tests passed (#{pass_count})"

          indent(format_colour(pass_summary, :success), 4)
        end

        def percentage_of_examples(count, total)
          percentage = (count.to_f / total) * 100.0
          "#{percentage.round(2)}%"
        end

        def failed_examples_output(notification)
          failed_examples_output = notification.failed_examples.map do |example|
            failed_example_output(example)
          end

          build_examples_output(failed_examples_output)
        end

        def build_examples_output(output)
          output.join("\n\n\t")
        end

        def format_colour(str, status)
          RSpec::Core::Formatters::ConsoleCodes.wrap(str, status)
        end

        def format_example_summary(example)
          full_description = example.full_description
          location = example.location
          "#{full_description} - #{location}"
        end

        def failed_example_output(example)
          msg = example.execution_result.exception.message
          formatted_err_message = sanitize_msg(msg)
          summary = format_colour(format_example_summary(example), :failure)

          "#{summary} \n  #{formatted_err_message}"
        end

        def sanitize_msg(msg)
          msg.split("\n").map(&:strip).join("\n#{' ' * 10}")
        end

        def indent(str, count)
          indent = ' ' * count
          indent + str
        end
      end
    end
  end
end
