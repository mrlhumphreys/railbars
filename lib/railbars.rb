require 'cgi'

require 'railbars/version'

# :nodoc:
module Railbars

end

require 'railbars/view_helpers'
require 'railbars/railtie' if defined?(Rails)
