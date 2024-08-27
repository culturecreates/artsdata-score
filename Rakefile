require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
end

# New task to merge files in shacl/partials
task :build do
  output_file = 'shacl/shacl_for_scoring.ttl'
  partials_dir = 'shacl/partials/*.ttl'
  
  # Read and concatenate all files in the partials directory
  merged_content = FileList[partials_dir].map do |file|
    File.read(file)
  end.join("\n")

  # Write the merged content to the output file
  File.open(output_file, 'w') do |file|
    file.write(merged_content)
  end

  puts "Merged files into #{output_file}"
end


task default: :test