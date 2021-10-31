Application.configure do |app|
  log_dev = app.production? ? STDOUT : app.root.concat('/', Settings.logger.path)
  logger = Ougai::Logger.new(log_dev, level: Settings.logger.level)

  logger.formatter = Ougai::Formatters::Readable.new if app.development?

  logger.before_log = lambda do |data|
    data[:service] = { name: Settings.app.name }
    data[:request_id] ||= Thread.current[:request_id]
  end

  app.set :logger, logger
end

Sequel::Model.db.loggers.push(Application.logger)
