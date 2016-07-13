require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/books')
require('./lib/author')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @books = Book.all()
  @authors = Author.all()
  erb(:index)
end

get('/books') do
  @books = Book.all()
  @authors = Author.all()
  erb(:index)
end

get('/authors') do
  @books = Book.all()
  @authors = Author.all()
  erb(:index)
end

post('/books') do
  title = params.fetch('title')
  author_name = params.fetch('author_id')
  author = Author.new({:author_name => author_name, :id => nil})
  author.save()
  book = Book.new({:title => title, :author_id => author.id(), :id => nil})
  book.save()
  @book = book
  @books = Book.all()
  @author = author
  @authors = Author.all()
  erb(:index)
end

get('/books/:id') do
  @book = Book.find(params.fetch('id').to_i())
  erb(:book)
end

post('/authors') do
  title = params.fetch('title')
  author_name = params.fetch('author_id')
  author = Author.new({:author_name => author_name, :id => nil})
  author.save()
  book = Book.new({:title => title, :author_id => author.id(), :id => nil})
  book.save()
  @book = book
  @books = Book.all()
  @author = author
  @authors = Author.all()
  erb(:index)
end

delete('/books/delete/') do
  @book = Book.find(params.fetch('book_id').to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
end

patch('/books/update/:id') do
  title = params.fetch("title")
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title =>title})
  erb(:book)
end
