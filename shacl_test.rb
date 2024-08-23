require 'minitest/autorun'
require 'rdf'
require 'shacl'
require 'rdf/turtle'

class ShaclTest < Minitest::Test
  def setup
    # shacl_files = Dir.glob("shacl/*.ttl")
    # shapes_graph = RDF::Graph.new
    # shacl_files.each do |file|
    #   shapes_graph << RDF::Graph.load(file)
    # end
    # @shacl = SHACL.get_shapes(shapes_graph)
  end

  def test_bad_facebook_event
    shacl = SHACL.open("shacl/check_facebook_link.ttl")
    graph = RDF::Graph.load("fixtures/event_link_bad_facebook.jsonld")
    report =  shacl.execute(graph) 
    puts report 
    assert !report.conform?,"#{report}"
  end

  def test_good_facebook_event
    shacl = SHACL.open("shacl/check_facebook_link.ttl")
    graph = RDF::Graph.load("fixtures/event_link_good_facebook.jsonld")
    report =  shacl.execute(graph)  
    
    assert report.conform?,"#{report}"
  end
end