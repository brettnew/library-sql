require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/books')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @books = Book.all()
  erb(:index)
end

get('/books') do
  @books = Book.all()
  erb(:index)
end

get('/authors') do
  erb(:index)
end

post('/books') do
  title = params.fetch('title')
  author = params.fetch('author_id')
  book = Book.new({:title => title, :author => nil, :id => nil})
  book.save()
  @book = book
  erb(:index)
end
