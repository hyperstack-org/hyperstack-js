# frozen_string_literal: true

require 'corelib/string/unpack'
require 'opal/compiler'

`window.HyperstackOpts = {'transport': 'none'}`

Document.ready? do
  # rubocop:disable Lint/RescueException
  # need to catch and report all exceptions
  promises = []
  code     = []

  Element['script[type="text/ruby"]'].each_with_index do |script_tag, index|
    src = script_tag.attr('src')

    if src
      promises << HTTP.get(src).then do |response|
        code[index] = response.body
      end
    else
      code[index] = script_tag.html
    end
  end

  Promise.when(*promises).then do
    compiled_code        = nil
    continue_to_mounting = nil

    begin
      compiled_code = Opal::Compiler.new(code.join("\n")).compile
    rescue Exception => e
      message = "Error raised while compiling: #{e.message}"
      `console.error(message)`
    end

    if compiled_code
      begin
        `eval(compiled_code)`
        continue_to_mounting = true
      rescue Exception => e
        message = "Error raised during execution: #{e.message}"
        `console.error(message)`
      end
    end

    if continue_to_mounting
      Element['[data-hyperstack-mount]'].each do |mount_point|
        component_name = mount_point.attr('data-hyperstack-mount')
        component      = nil

        begin
          component = Object.const_get(component_name)
        rescue Exception
          message = "Could not find Component class named #{component_name}"
          `console.error(message)`
          next
        end

        params = Hash[*Hash.new(mount_point.data).collect do |name, value|
          [name.underscore, value] unless name == 'reactrbMount'
        end.compact.flatten(1)]

        element = Hyperstack::Component::ReactAPI.create_element(component, params)

        Hyperstack::Component::ReactAPI.render(element, mount_point)
      end
    end
  end
  # rubocop:enable Lint/RescueException
end
