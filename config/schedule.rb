env :PATH, ENV['PATH']
set :environment, :development
set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}

every 1.minute do
  runner "Apps.get_app"
end