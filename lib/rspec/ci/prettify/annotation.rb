# frozen_string_literal: true
module RSpec
  module Ci
    module Prettify
        class Annotation
            def initialize(notification)
                @notification = notification
                @example = notification.example
            end

            attr_reader :example, :notification

            def line
                location.split(':')[1]
            end

            def error
                msg = notification.message_lines.join("\n")
                format_annotation_err(msg)
            end

            def file
                File.realpath(location.split(':')[0]).sub(/\A#{github_workspace_file_path}#{File::SEPARATOR}/, '')
            end

            private

            def format_annotation_err(str)
                stripped_str = strip_ansi_colours(str)
                formatted_str = stripped_str.gsub("\n", '').gsub('"', "'")
                formatted_str.squeeze(" ")
            end

            # running --force-color for rspec for a more readable CI
            # output works great but unfortunately ANSI colours dont
            # get parsed properly on github annotations therefore
            # make them harder to read. Stripping any ANSI colours 
            # on annotations here gives us the best of both worlds
            # readable annotations and readable coloured CI
            def strip_ansi_colours(str)
                str.gsub(/\e\[(\d+)(;\d+)*m/, '')
            end

            def github_workspace_file_path
                File.realpath(ENV.fetch('GITHUB_WORKSPACE', '.'))
            end

            def location
                example.location
            end
        end
    end
  end
end