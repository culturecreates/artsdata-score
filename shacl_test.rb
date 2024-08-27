require 'minitest/autorun'
require 'rdf'
require 'shacl'
require 'rdf/turtle'

class ShaclTest < Minitest::Test

  def test_event_start_date
    shacl = SHACL.open("shacl/event_start_date.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/event_start_date_bad.jsonld")
    report =  shacl.execute(graph)  
    assert_equal 2,report.results.length

    # good
    graph = RDF::Graph.load("fixtures/event_start_date_good.jsonld")
    report =  shacl.execute(graph)  
    puts report
    assert report.conform?,"#{report}"
  end

  def test_name
    shacl = SHACL.open("shacl/event_name.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/event_name_bad.jsonld")
    report =  shacl.execute(graph)  
    puts report
    assert_equal 2,report.results.length

    # good
    graph = RDF::Graph.load("fixtures/event_name_good.jsonld")
    report =  shacl.execute(graph)  
    puts report
    assert report.conform?,"#{report}"
  end

  def test_place
    shacl = SHACL.open("shacl/place.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/place_bad.jsonld")
    report =  shacl.execute(graph)  
    assert_equal 2,report.results.length

    # good
    graph = RDF::Graph.load("fixtures/place_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?,"#{report}"
  end

  def test_postal_address_postal_code
    shacl = SHACL.open("shacl/postal_address_postal_code.ttl")

    # bad
    graph = RDF::Graph.load("fixtures/postal_address_postal_code_bad.jsonld")
    report =  shacl.execute(graph)  
    puts report
    assert_equal 2,report.results.length

    # good
    graph = RDF::Graph.load("fixtures/postal_address_postal_code_good.jsonld")
    report =  shacl.execute(graph)  
    puts report
    assert report.conform?,"#{report}"
  end

  def test_sameas_facebook_event
    shacl = SHACL.open("shacl/check_facebook_link.ttl")

    graph = RDF::Graph.load("fixtures/sameas_facebook_event_bad.jsonld")
    report =  shacl.execute(graph) 
    assert !report.conform?,"#{report}"

    graph = RDF::Graph.load("fixtures/sameas_facebook_event_good.jsonld")
    report =  shacl.execute(graph)  
    assert report.conform?,"#{report}"
  end




end