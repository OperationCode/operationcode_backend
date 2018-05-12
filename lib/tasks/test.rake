namespace :test do
  task :policies => 'test:prepare' do
    $: << 'test'
    Minitest.rake_run(['test/policies'])
  end
end

Rake::Task['test:run'].enhance ['test:policies']
