$VERBOSE = nil
require 'minitest/autorun'
require 'rdf'
require 'shacl'
require 'rdf/turtle'
require 'sparql'


class SparqlTest < Minitest::Test
  def setup
    @sparql = SPARQL.parse(File.read("sparql/score_algorithm.sparql"), update: true)
    shacl_files = Dir.glob("shacl/partials/*.ttl")
    shapes_graph = RDF::Graph.new
    shacl_files.each do |file|
      shapes_graph << RDF::Graph.load(file)
    end
    @shacl = SHACL.get_shapes(shapes_graph)
    
  end

  def test_required_properties
    # If any of the three required properties is missing, the score would be 0 (zero), no matter how good the rest of the structured data is.
    # An event with all three required properties would have a score of 12 + (2 x 8) = 28.
    graph = RDF::Graph.load("fixtures/score_tests.jsonld")
    graph <<  @shacl.execute(graph) 
    graph.query(@sparql)
    # puts graph.dump(:ttl)
    actual = graph.query([RDF::URI('http://example.org/1'), RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
    assert_equal 0, actual, "Score for event 1 should be 0"
    actual = graph.query([RDF::URI('http://example.org/2'), RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
    assert_equal 0, actual, "Score for event 2 should be 0"
    actual = graph.query([RDF::URI('http://example.org/3'), RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
    assert_equal 30, actual, "Score for event 3 should be 28 + 2 for optional event id"
  end

  def test_event_types
    # Should accepts TheaterEvent, DanceEvent, MusicEvent, VisualArtsEvent, FilmEvent.
    graph = RDF::Graph.load("fixtures/event_types.jsonld")
    graph <<  @shacl.execute(graph) 
    graph.query(@sparql)
    actual = graph.query([nil, RDF::URI('http://example.org/score'), 0]).count
    
    assert_equal 4, actual, "All Event types should have a report"
  end

  # test high scores and precentages
  def test_high_scores
    graph = RDF::Graph.load("fixtures/score_high_tests.jsonld")
    graph <<  @shacl.execute(graph) 
    graph.query(@sparql)
  
    actual = graph.query([RDF::URI('http://example.org/high_score_1'), RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
    assert_equal 43, actual, "Not expected score. Score was #{actual}"
    actual = graph.query([RDF::URI('http://example.org/high_score_2'), RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
    assert_equal 63, actual, "Not expected score. Score was #{actual}"
    actual = graph.query([RDF::URI('http://example.org/high_score_3'), RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
   
    assert_equal 74, actual, "Not expected score. Score was #{actual}"
    actual = graph.query([RDF::URI('http://example.org/high_score_3'), RDF::URI('http://example.org/scorePercent'), nil]).first.object.value.to_i
    assert_equal 100, actual, "Not expected scorePercent. Score was #{actual}"
  end

  # Test that events with an @id are awarded 2 points
  def test_event_id
    graph = RDF::Graph.load("fixtures/score_event_id.jsonld")
    graph <<  @shacl.execute(graph) 
    graph.query(@sparql)
    actual = graph.query([ RDF::URI('http://event1'), RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
    assert_equal 34, actual, "event1 should have a score of 34 but had #{actual}"
    actual = graph.query([ nil, RDF::URI('http://example.org/score'), 30]).count
    assert_equal  1, actual, "event blanknode should have a score of 30"
    actual = graph.query([ RDF::URI('http://event3'),  RDF::URI('http://example.org/score'), nil]).first.object.value.to_i
    assert_equal  33, actual, "event3 should have a score of 33 but had #{actual}"
  end


end