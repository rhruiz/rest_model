module Transcriber
  class Resource
    module Parser
      module Property
        def parse(item, resource = nil)
          value = digg(item)
          translate_from_input(serializer.serialize(value), resource)
        end

        def digg(input)
          input_path.inject(input) {|buffer, key| buffer = buffer[key]}
        end

        def translate_from_input(value, resource)
          case translations
          when nil  then value
          when Hash then translations.key(value)
          when Proc then resource.instance_eval(&translations)
          end
        end

        def translate_to_input(value, resource)
          case translations
          when Hash then translations[value]
          when Proc then resource.instance_eval(&translations)
          end
        end

        def from_hash(value, resource = nil)
          value
        end

        def to_input!(value, resource, options = {})
          input_value = nil

          begin
            if translations
              input_value = translate_to_input(value, resource)
            else
              input_value = serializer.desserialize(value)
            end
          rescue => exception
            raise exception if options[:fail]
          end

          input = {}
          path = input_path

          if path.any?
            last = path.pop
            key_input = path.inject(input) {|buffer, key| buffer[key] = {}; buffer[key]}
            key_input[last] = input_value
          else
            input.merge!(input_value)
          end

          input
        end
      end
    end
  end
end
