Filterrific.configure do |config|
    config.add_filter(:by_name, :string, label: 'Book Name')
    config.add_filter(:by_auther_name, :string, label: 'auther Name')
    config.add_filter(:by_release_date, :date, label: 'Release Date')
  end
  