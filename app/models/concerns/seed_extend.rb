module SeedExtend
  def get_model_filename(model)
    model.to_s.split(/(?=[[:upper:]])/).map(&:downcase).join("_")
  end

  def seed_model_for(model)
    model_filename = get_model_filename(model)
    yml_file = File.expand_path("db/models/#{model_filename}.yml", Rails.root)
    sql_file = File.expand_path("db/models/#{model_filename}.sql", Rails.root)

    if File.exist? yml_file
      model.create(YAML.load_file(yml_file).values)
    elsif File.exist? sql_file
      conn = ActiveRecord::Base.connection()
      File.foreach(sql_file) do |line|
        conn.execute(line)
      end
    end
  end

  def seed_model_all
    Dir["#{Rails.root}/db/models/*.yml", "#{Rails.root}/db/models/*.sql"].each do |file|
      basename = File.basename(file).sub(/\.\w+$/, "")
      seed_model_for(Math.const_get(basename.camelcase)) unless File.open(file).size.zero?
    end
  end
end
