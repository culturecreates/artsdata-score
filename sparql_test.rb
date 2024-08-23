require 'minitest/autorun'
require 'linkeddata'

class SparqlTest < Minitest::Test
  def setup
    @sparql = SPARQL.parse(File.read("sparql/score.sparql"), update: true)
  end

  def test_required_properties
    # If any of the three required properties is missing, the score would be 0 (zero), no matter how good the rest of the structured data is.
    # An event with all three required properties would have a score of 12 + (2 x 8) = 28.
    graph = RDF::Graph.load("fixtures/test_required_properties.jsonld")
    graph.query(@sparql)
    puts graph.dump(:ttl)
    assert_equal 8, graph.count

  end

end