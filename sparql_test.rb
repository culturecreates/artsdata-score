require 'minitest/autorun'
require 'linkeddata'

class SparqlTest < Minitest::Test
  def setup
    @sparql = SPARQL.parse(File.read("sparql/score.sparql"), update: true)
    shacl_files = Dir.glob("shacl/*.ttl")
    shapes_graph = RDF::Graph.new
    shacl_files.each do |file|
      shapes_graph << RDF::Graph.load(file)
    end
    @shacl = SHACL.get_shapes(shapes_graph)
    
  end

  def test_required_properties
    # If any of the three required properties is missing, the score would be 0 (zero), no matter how good the rest of the structured data is.
    # An event with all three required properties would have a score of 12 + (2 x 8) = 28.
    graph = RDF::Graph.load("fixtures/required_properties.jsonld")
    graph <<  @shacl.execute(graph) 
    graph.query(@sparql)
    puts graph.dump(:ttl)
    actual = graph.query([RDF::URI('http://example.org/2'), RDF::URI('http://example.org/scoreTotal'), nil]).first.object.value.to_i
    assert_equal 28, actual
    actual = graph.query([RDF::URI('http://example.org/1'), RDF::URI('http://example.org/scoreTotal'), nil]).first.object.value.to_i
    assert_equal 0, actual

  end

end