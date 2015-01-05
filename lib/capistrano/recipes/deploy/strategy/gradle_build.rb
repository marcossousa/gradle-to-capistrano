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
            run_locally "cd #{gradle_working_dir} && mv build/distributions/#{File.basename(destination)}.tar #{copy_dir}"
          end

          run_locally "mkdir #{copy_dir}/#{File.basename(destination)}"
          create_revision_file
          run_locally "tar rf #{copy_dir}/#{File.basename(destination)}.tar #{copy_dir}/#{File.basename(destination)}/REVISION"
          run_locally "gzip #{copy_dir}/#{File.basename(destination)}.tar"
          distribute!
        ensure
          rollback_changes
        end

        def rollback_changes
          run_locally "cd #{gradle_working_dir} && rm -rf build/distributions/*"
          run_locally "rm -rf #{copy_dir}/#{File.basename(destination)}*"
        end
      end
    end
  end
end
