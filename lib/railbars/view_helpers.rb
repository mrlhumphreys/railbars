module Railbars

  # = View Helpers
  #
  # Handlebar Helpers for Rails Views.
  module ViewHelpers
    # Handlebars helper, returns an expression, helper or block handlebar string
    #
    # @param [String] name
    #   The name of the value for the expression or the name of the block.
    #
    # @param [Array<Object>] params
    #   The parameters the helper takes
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hb('hello')
    #   #=> "{{hello}}"
    #
    #   irb> hb('myHelper', 'param1', 'param2')
    #   #=> "{{myHelper param1 param2}}"
    #
    #   irb> hb('myBlockHelper', 'param') { '<p>Hello</p>' }
    #   #=> "{{#myBlockHelper param}}<p>Hello</p>{{/myBlockHelper}}"
    def hb(name, *params, &block)
      if block
        hbblock(name, *params, &block)
      else
        if params.any?
          hbhelper(name, *params)
        else
          hbexp(name)
        end
      end
    end

    # Handlebars expression helper, returns the value wrapped in handlebars
    #
    # @param [String] exp
    #   The value to be wrapped
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbexp('hello')
    #   #=> "{{hello}}"
    def hbexp(exp)
      "{{#{exp}}}"
    end

    # Handlebars block helper, returns the contents of the block wrapped with the specified block helper
    #
    # @param [String] name
    #   The name of the block helper
    #
    # @param [Array<Object>] params
    #   The parameters the helper takes
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbblock('myBlockHelper', 'param') { '<p>Hello</p>' }
    #   #=> "{{#myBlockHelper param}}<p>Hello</p>{{/myBlockHelper}}"
    def hbblock(name, *params, &block)
      "{{##{name} #{hbparams(*params)}}}#{capture(&block)}{{/#{name}}}".html_safe
    end

    # Handlebars helper helper, returns the helper name with params
    #
    # @param [String] name
    #   The name of the helper
    #
    # @param [Array<Object>] params
    #   The parameters the helper takes
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbhelper('myHelper', 'param1', 'param2')
    #   #=> "{{myHelper param1 param2}}"
    def hbhelper(name, *params)
      "{{#{name} #{hbparams(*params)}}}"
    end

    # Handlebars escape helper, returns the value wrapped in escaped handlebars
    #
    # @param [String] value
    #   The value to be wrapped
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbunescape('hello')
    #   #=> "{{{hello}}}"
    def hbunescape(value)
      "{{{#{value}}}}"
    end

    # Handlebars partial helper, returns the value wrapped in partial handlebars
    #
    # @param [String] name
    #   The name of the partial
    #
    # @param [Array<Object>] params
    #   The parameters the partial takes
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbunescape('partialName', 'param1', 'param2')
    #   #=> "{{> partial param1 param2}}"
    def hbpartial(name, *params)
      "{{> #{name} #{hbparams(*params)} }}"
    end

    # Handlebars each helper, returns the contents of the block wrapped with each handlebars
    #
    # @param [String] item
    #   The name of item
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbeach('point') { '<li>Hello</li>' }
    #   #=> "{{#each point}}<li>Hello</li>{{/each}}"
    def hbeach(item, &block)
      hbblock('each', item, &block)
    end

    # Handlebars if helper, returns the contents of the block wrapped with if handlebars
    #
    # @param [String] condition
    #   The condition of this block
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbif('present') { '<p>Hello</p>' }
    #   #=> "{{#if present}}<p>Hello</p>{{/if}}"
    def hbif(condition, &block)
      hbblock('if', condition, &block)
    end

    # Handlebars else helper, returns else wrapped in handlebars
    #
    # @return [String]
    #
    # ==== Example:
    #   irb> hbelse
    #   #=> "{{hbelse}}"
    def hbelse
      hbexp('else')
    end

    # Translates params into handlebars param literals and hash literals
    #
    # @param [Array<Object>] params
    #   The values to be translated
    #
    # @return [String]
    #
    # ==== Example:
    #   # Translate a hash into handlebars hash literals
    #   irb> translate_values('cat', 'dog', food: 'lots')
    #   #=> "cat dog food=\"lots\""
    def hbparams(*params)
      if params.empty?
        nil
      else
        values = translate_values(params.select { |p| p.is_a?(String) })
        hash = translate_hash(params.last.is_a?(Hash) ? params.last : {})

        [values, hash].compact.join(' ')
      end
    end

    # Translates params into handlebars param literals
    #
    # @param [Array] values
    #   The values to be translated
    #
    # @return [String]
    #
    # ==== Example:
    #   # Translate a hash into handlebars hash literals
    #   irb> translate_values('rin', 'len')
    #   #=> "rin len"
    def translate_values(values)
      if values.empty?
        nil
      else
        values.join(' ')
      end
    end

    # Translates a hash into handlebars hash literals
    #
    # @param [Hash] hash
    #   The hash to be translated
    #
    # @return [String]
    #
    # ==== Example:
    #   # Translate a hash into handlebars hash literals
    #   irb> translate_hash({miku: "senbonzakura", luka: "double lariat"})
    #   #=> "miku=\"senbonzakura\" luka=\"double lariat\""
    def translate_hash(hash)
      if hash.empty?
        nil
      else
        hash.map do |k, v|
          value = v.is_a?(String) ? "\"#{v}\"" : v
          "#{k}=#{value}"
        end.join(' ')
      end
    end
  end
end
