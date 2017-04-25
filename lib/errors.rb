# frozen_string_literal: true
#
module XmlJats
  class DoctypeError < RuntimeError
  end
  class PublicIdentifierNotSupported < RuntimeError
  end
  class PublicIdentifierNotDeclared < RuntimeError
  end
end
