$VERBOSE = nil
require 'minitest/autorun'
require 'rdf'
require 'shacl'
require 'rdf/turtle'

class ShaclTest < Minitest::Test

  def test_event_start_date
    shacl = SHACL.open("shacl/partials/event_start_date.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/event_start_date_bad.jsonld")
    report =  shacl.execute(graph)  
    assert_equal 2,report.results.length, "Some bad data is not being caught. #{report}"

    # good
    graph = RDF::Graph.load("fixtures/event_start_date_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?, "Some good data is not passing. #{report}"
  end

  def test_name
    shacl = SHACL.open("shacl/partials/event_name.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/event_name_bad.jsonld")
    report =  shacl.execute(graph)  
    assert_equal 2,report.results.length, "Some bad data is not being caught. #{report}"

    # good
    graph = RDF::Graph.load("fixtures/event_name_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?, "Some good data is not passing. #{report}"
  end

  def test_place
    shacl = SHACL.open("shacl/partials/place.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/place_bad.jsonld")
    report =  shacl.execute(graph)  
    assert_equal 2,report.results.length, "Some bad data is not being caught. #{report}"

    # good
    graph = RDF::Graph.load("fixtures/place_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?, "Some good data is not passing. #{report}"
  end

  def test_event_place
    shacl = SHACL.open("shacl/partials/event_place.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/event_place_bad.jsonld")
    report =  shacl.execute(graph)  
    assert_equal 2,report.results.length, "Some bad data is not being caught. #{report}"

    # good
    graph = RDF::Graph.load("fixtures/event_place_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?, "Some good data is not passing. #{report}"
  end

  def test_postal_address_postal_code
    shacl = SHACL.open("shacl/partials/postal_address_postal_code.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/postal_address_postal_code_bad.jsonld")
    report =  shacl.execute(graph)  
    assert_equal 2,report.results.length, "Some bad data is not being caught. #{report}"

    # good
    graph = RDF::Graph.load("fixtures/postal_address_postal_code_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?, "Some good data is not passing. #{report}"
  end

  def test_sameas_facebook_event
    shacl = SHACL.open("shacl/partials/check_facebook_link.ttl")

    graph = RDF::Graph.load("fixtures/sameas_facebook_event_bad.jsonld")
    report =  shacl.execute(graph) 
    assert !report.conform?, "Some bad data is not being caught. #{report}"

    graph = RDF::Graph.load("fixtures/sameas_facebook_event_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?, "Some good data is not passing. #{report}"
  end




end