# frozen_string_literal: true
#
module XmlJats
  class DoctypeError < RuntimeError
    def initialize(msg = 'No doctype declared')
      super
    end
  end

  class PublicIdentifierNotSupported < RuntimeError
    def initialize(msg = 'Public identifier not declared')
      super
    end
  end

  class PublicIdentifierNotDeclared < RuntimeError
    def initialize(msg = 'Public identifier not supported')
      super
    end
  end
end
