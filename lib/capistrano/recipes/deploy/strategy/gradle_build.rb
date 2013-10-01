require 'capistrano/recipes/deploy/strategy/copy'

module Capistrano
  module Deploy
    module Strategy
      class GradleBuild < Copy
        def deploy!
          execute "Running gradle build command" do
            unless self.gradle_working_dir
              set :gradle_working_dir, "./"
            end

            run_locally "cd #{gradle_working_dir} && #{gradle_home}/gradle #{gradle_cmd.gsub!('{release_name}', "#{File.basename(destination)}.tar")}"
            run_locally "cd #{gradle_working_dir} && mv build/distributions/#{File.basename(destination)}.tar /tmp/"
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
          run_locally "cd #{gradle_working_dir} && rm -rf build/distributions/*"
          run_locally "rm -rf /tmp/#{File.basename(destination)}*"
        end
      end
    end
  end
end
