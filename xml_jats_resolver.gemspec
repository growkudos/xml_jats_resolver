# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'xml_jats_resolver'
  spec.version       = '0.0.1'
  spec.authors       = ['Kevin Etienne']
  spec.email         = ['kevin@growkudos.com']

  spec.summary       = 'Resolve DTD for XML JATS'
  spec.description   = 'Resolve DTD for XML JATS with Nokogiri'
  spec.homepage      = 'https://github.com/growkudos/xml_jats_resolver'
  spec.license       = 'BSD'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'nokogiri', '~> 1.7.0.1'
end
