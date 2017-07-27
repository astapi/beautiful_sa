require 'beautiful_sa'
require 'thor'
require 'marionette'

module BeautifulSa
  class CLI < Thor
    desc "update_service cluster_name service_name", ""
    def update_service(cluster_name, service_name, options = {})
      service = Marionette::Aws::Service.new
      current_task = service.current_task_definition(cluster_name, service_name)
      task_name = current_task.split(':').first
      task = Marionette::Aws::Task.new
      task.update_task(task_name, options)

      service.update_service(cluster_name, service_name, task_name)
    end

    desc "run_task cluster_name task_name", ""
    def run_task(cluster_name, task_name)
      task = Marionette::Aws::Task.new
      task.run_task(cluster_name, task_name)
    end
  end
end
