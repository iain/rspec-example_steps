module RSpec
  module ExampleSteps
    module DocumentationFormatter
      def self.included(base)
        base.class_eval do
          include InstanceMethods

          alias :example_started_without_steps :example_started
          alias :example_started :example_started_with_steps

          alias :example_passed_without_steps :example_passed
          alias :example_passed :example_passed_with_steps
        end
      end

      module InstanceMethods
        def example_started_with_steps(example)
          example_started_without_steps(example)

          if example.options[:with_steps]
            full_message = "#{current_indentation}#{example.description}"
            output.puts white(full_message)
          end
        end

        def example_passed_with_steps(example)
          example_passed_without_steps(example) unless example.options[:with_steps]
        end

        def example_step_passed(example_group, type, message)
          full_message = "#{current_indentation}  #{type.to_s.capitalize} #{message}"
          output.puts green(full_message)
        end
      end
    end
  end
end