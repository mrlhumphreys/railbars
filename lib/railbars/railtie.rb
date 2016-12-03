require 'railbars/view_helpers'

module Railbars
  # :nodoc:
  class Railtie < Rails::Railtie
    initializer "railbars.view_helpers" do
      ActionView::Base.send :include, Railbars::ViewHelpers
    end
  end
end