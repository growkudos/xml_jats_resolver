# frozen_string_literal: true
require 'test_helper.rb'

dtds = {
  # NLM
  '-//NLM//DTD Journal Archiving and Interchange DTD v1.0 20021201//EN': 'archiving_dtd/archiving/1.0/dtd/',
  '-//NLM//DTD Journal Archiving and Interchange DTD v1.1 20031101//EN': 'archiving_dtd/archiving/1.1/dtd/',
  '-//NLM//DTD Journal Archiving and Interchange DTD v2.0 20040830//EN': 'archiving_dtd/archiving/2.0/dtd/',
  '-//NLM//DTD Journal Archiving and Interchange DTD v2.1 20050630//EN': 'archiving_dtd/archiving/2.1/dtd/',
  '-//NLM//DTD Journal Archiving and Interchange DTD v2.2 20060430//EN': 'archiving_dtd/archiving/2.2/dtd/',
  '-//NLM//DTD Journal Archiving and Interchange DTD v2.3 20070202//EN': 'archiving_dtd/archiving/2.3/dtd/',
  '-//NLM//DTD Journal Archiving with OASIS Tables v2.3 20070813//EN': 'archiving_dtd/archiving/2.3/oasis_dtd/',
  '-//NLM//DTD Journal Archiving and Interchange DTD v3.0 20080202//EN': 'archiving_dtd/archiving/3.0/dtd/',
  '-//NLM//DTD Journal Archiving with OASIS Tables v3.0 20080202//EN': 'archiving_dtd/archiving/3.0/oasis_dtd/',
  # NISO
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD v0.4 20110131//EN': 'jats/archiving/0.4/dtd/',
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD (OASIS Tables) v0.4 20110131//EN': 'jats/archiving/0.4/dtd/',
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD v1.0 20120330//EN': 'jats/archiving/1.0/dtd/',
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with OASIS Tables v1.0 20120330//EN': 'jats/archiving/1.0/dtd/',
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD v1.1 20151215//EN': 'jats/archiving/1.1/mathml2_dtd/',
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with MathML3 v1.1 20151215//EN': 'jats/archiving/1.1/mathml3_dtd/',
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with OASIS Tables v1.1 20151215//EN': 'jats/archiving/1.1/oasis_mathml2_dtd/',
  '-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with OASIS Tables with MathML3 v1.1 20151215//EN': 'jats/archiving/1.1/oasis_mathml3_dtd/',
  # Atypon
  '-//Atypon//DTD Atypon Systems Archival NLM DTD Suite v2.2.0 20090301//EN': 'atypon/2.2/dtd/',
  '-//Atypon//DTD Atypon Systems Journal Archiving and Interchange NLM DTD v3.0.0 20090430//EN': 'atypon/3.0.0/dtd/',
  '-//Atypon//DTD Atypon Systems Journal Archiving and Interchange NLM DTD v3.0.2 20101108//EN': 'atypon/3.0.3/dtd/',
  '-//Atypon//DTD Atypon Systems Journal Archiving and Interchange NLM DTD v3.0.6 20130326//EN': 'atypon/3.0.6/dtd/'
}

describe XmlJats::Resolver, 'Resolve DTD correctly' do
  describe 'when asked about resolving a public identifier' do
    let(:resolver) { XmlJats::Resolver.new(1) }

    it 'should match the public identifier to a path' do
      dtds.each do |public_id, expected_path|
        path = resolver.dtd_path(public_id)
        path.must_include(expected_path)
      end
    end

    it 'should raise a KeyError if the public identifier is not defined' do
      proc { resolver.dtd_path('my custom dtd') }.must_raise XmlJats::PublicIdentifierNotSupported
    end
  end

  describe 'when asked about parsing the XML with the DTD' do
    let(:dirname) { File.dirname(__FILE__) }

    it 'should return an xml with a valid JATS file' do
      filepath = File.join(dirname, 'xml', 'jats.xml')
      document = File.open(filepath).read

      resolver = XmlJats::Resolver.new(document)
      xml = resolver.parse
      xml.must_be_instance_of Nokogiri::XML::Document
    end

    it 'should raise an error if the doctype is not known' do
      filepath = File.join(dirname, 'xml', 'unknown.xml')
      document = File.open(filepath).read

      resolver = XmlJats::Resolver.new(document)
      proc { resolver.parse }.must_raise XmlJats::PublicIdentifierNotSupported
    end

    it 'should raise an error if the dtd is not available' do
      filepath = File.join(dirname, 'xml', 'unknown_dtd.xml')
      document = File.open(filepath).read

      resolver = XmlJats::Resolver.new(document)
      proc { resolver.parse }.must_raise XmlJats::PublicIdentifierNotDeclared
    end

    it 'should return an error if the dtd is not present' do
      filepath = File.join(dirname, 'xml', 'no_dtd.xml')
      document = File.open(filepath).read

      resolver = XmlJats::Resolver.new(document)
      proc { resolver.parse }.must_raise XmlJats::DoctypeError
    end
  end
end
