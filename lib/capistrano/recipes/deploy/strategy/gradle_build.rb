require 'capistrano/recipes/deploy/strategy/copy'

module Capistrano
  module Deploy
    module Strategy
      class GradleBuild < Copy
        def deploy!
          execute "Running gradle build command" do
            run_locally "#{gradle_home}/gradle #{gradle_cmd.gsub!('{release_name}', "#{File.basename(destination)}.tar")}"
            run_locally "mv build/distributions/#{File.basename(destination)}.tar /tmp/"
          end

          execute "Decompressing gradle build to put REVISON file" do
            run_locally "cd /tmp/ && tar -xf /tmp/#{File.basename(destination)}.tar"
          end
          create_revision_file
          compress_repository
          distribute!
        ensure
          rollback_changes
        end

        def rollback_changes
          run_locally "rm -rf build/distributions/*"
          run_locally "rm -rf /tmp/#{File.basename(destination)}*"
        end
      end
    end
  end
end
