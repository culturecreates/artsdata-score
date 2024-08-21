require 'minitest/autorun'
require 'linkeddata'

class SparqlTest < Minitest::Test
  def setup
    @graph = RDF::Graph.load("fixtures/basic_event.jsonld")
  end

  def test_that_eventforindex_is_removed
    sparql = File.read("sparql/check_start_date.sparql")
    graph = @graph.query(SPARQL.parse(sparql, update: true))
    puts graph.dump(:ttl)
    assert_equal 8, graph.count
  end
end