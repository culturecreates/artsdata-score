require 'rdf'
require 'sparql'
require 'shacl'
require 'linkeddata'
require 'csv'
require 'fileutils'

filename = ARGV[0].split('/').last.split('.').first

graph = RDF::Graph.load("output/#{filename}.jsonld")

SHACL.open('shacl/shacl_for_scoring.ttl').execute(graph)

SPARQL.execute(File.read('sparql/score_algorithm.sparql'), graph, update: true)
report = SPARQL.execute(File.read('sparql/report.sparql'), graph)

report.to_csv

if report.any?
  FileUtils.mkdir_p('reports')
  CSV.open("reports/#{filename}_report.csv", "w") do |csv|
    headers = report.first.to_h.keys
    csv << headers

    report.each do |solution|
      csv << headers.map { |header| solution[header].to_s }
    end
  end

  puts "CSV report generated: #{filename}_report.csv"
else
  puts "No results to generate CSV."
end