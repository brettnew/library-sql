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
  @books = Book.all()
  erb(:index)
end

post('/books') do
  title = params.fetch('title')
  # author_id = params.fetch('author_id')
  book = Book.new({:title => title, :author_id => 1, :id => nil})
  book.save()
  @book = book
  @books = Book.all()
  erb(:index)
end

post('/authors') do
  title = params.fetch('title')
  # author_id = params.fetch('author_id')
  book = Book.new({:title => title, :author_id => 1, :id => nil})
  book.save()
  @book = book
  erb(:index)
end
