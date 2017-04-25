# frozen_string_literal: true
require 'errors'
require 'nokogiri'

module XmlJats
  class Resolver
    attr_reader :errors

    def initialize(filestream)
      @filestream = filestream
      @dtds = {
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
    end

    def dtd_path(identifier = nil)
      if identifier.nil?
        xml = Nokogiri::XML.parse(@filestream)
        unless xml.internal_subset
          raise XmlJats::DoctypeError
        end
        unless xml.internal_subset.external_id
          raise XmlJats::PublicIdentifierNotDeclared
        end
        identifier ||= xml.internal_subset.external_id.to_sym
      end
      dtds_path = File.dirname(__FILE__)
      dtd = @dtds[identifier]
      unless dtd
        raise XmlJats::PublicIdentifierNotSupported, "Public identifier not supported: #{identifier}"
      end
      File.join(dtds_path, 'dtd', dtd)
    end

    def parse(url = nil)
      url ||= dtd_path
      options = Nokogiri::XML::ParseOptions::DTDVALID
      Nokogiri::XML.parse(@filestream, url, nil, options)
    end
  end
end
