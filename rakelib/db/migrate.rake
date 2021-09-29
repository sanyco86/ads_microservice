namespace :db do
  desc 'Generate migration'
  task :generate, %i[name] do |_, args|
    name = args[:name]
    abort('Missing migration file name') if name.nil?

    content = <<~STR
      # frozen_string_literal: true
      Sequel.migration do
        change do
        end
      end
    STR

    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    filename = File.join('db/migrate/', "#{timestamp}_#{name}.rb")
    File.write(filename, content)
    puts "Generated: #{filename}"
  end

  desc 'Run database migrate'
  task :migrate, %i[version] => :settings do |_, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      version = args.version.to_i if args.version
      migrate = File.expand_path('../../db/migrate', __dir__)

      Sequel::Migrator.run(db, migrate, target: version)
    end
  end

  desc 'Rollback migration'
  task :rollback, %i[step] => :settings do |_, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      step             = args[:step] ? Integer(args[:step]) : 1
      version          = 0
      target_migration = db[:schema_migrations].reverse_order(:filename).offset(step).first
      version          = Integer(target_migration[:filename].match(/([\d]+)/)[0]) if target_migration
      migrate       = File.expand_path('../../db/migrate', __dir__)

      Sequel::Migrator.run(db, migrate, target: version)
    end
  end
end
