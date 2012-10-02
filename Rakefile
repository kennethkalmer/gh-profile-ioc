desc "Fetch the data for a user specified with USER"
task :fetch do
  require 'octokit'

  File.open('data/user.json', 'w+') do |f|
    f.write Octokit.user( ENV['USER'] ).to_json
  end
end
