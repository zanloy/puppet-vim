#ignore %r{^spec/fixtures/$}
directories %w{manifests spec}

#guard 'rake', task: 'rspec' do
guard 'rspec', cmd: 'rspec --color --format documentation' do
  # Classes
  watch(%r{^manifests/(.+)\.pp$}) do |m|
    "spec/classes/#{m[1]}_spec.rb"
  end
  watch(%r{^spec/classes/(.+)_spec\.rb$}) do |m|
    "spec/classes/#{m[1]}.rb"
  end
end
