# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# 追加
workers Integer(ENV['WEB_CONCURRENCY'] || 2)

before_fork do
 
  PumaWorkerKiller.config do |config|
 
    # 1. サーバのRAMを記述する(MB単位)
    config.ram = 512
 
    # 2. メモリ使用率の確認頻度(秒単位) ※(例)24時間に1回
    config.frequency = 24 * 60 * 60
 
    # 3. メモリ使用率(%) ※(例)90%
    # ※2の確認時にこの値を超えるとWorkerが再起動される
    config.percent_usage = 0.90
 
    # 4. 2/3とは別にWorkerを再起動する周期(秒単位) ※(例)3分毎
    config.rolling_restart_frequency = 3 * 60 * 60
 
    # 5. 監視ログの出力
    config.reaper_status_logs = false
 
  end
  PumaWorkerKiller.start
end