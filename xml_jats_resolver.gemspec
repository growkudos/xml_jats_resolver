# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'xml_jats_resolver'
  spec.version       = '0.0.1'
  spec.authors       = ['Kudos']
  spec.email         = ['engineering@growkudos.com']

  spec.summary       = 'Resolve DTD for XML JATS'
  spec.description   = 'Resolve DTD for XML JATS with Nokogiri'
  spec.homepage      = 'https://github.com/growkudos/xml_jats_resolver'
  spec.license       = 'BSD'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'nokogiri', '~> 1.7.0.1'
  spec.add_development_dependency 'rake', '~> 12.0.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
