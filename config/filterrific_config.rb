Filterrific.configure do |config|
    config.add_filter(:by_name, :string, label: 'Book Name')
    config.add_filter(:by_auther_name, :string, label: 'auther Name')
    config.add_filter(:search_query , :string, label: 'Release Date')
  end
  