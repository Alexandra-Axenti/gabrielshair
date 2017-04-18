require('pry')
require("bundler/setup")
require('pg')

DB = PG.connect({:dbname => "ticket_development"})
  Bundler.require(:default)

  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
  also_reload("lib/*.rb")

get ('/') do
  @categories = Category.all()
  @events= Event.all()
  @venues= Venue.all()
  @artists=Artist.all()
  @offers=Offer.all()
  erb(:index)
end

post ('/event') do
  name = params.fetch('name')
  date = params.fetch('date')
  imageurl = params.fetch('imageurl')
  event = Event.create({:name => name, :date => date, :imageurl => imageurl})
  if event.save()
    redirect ('/')
  else
    erb(:errors)
  end
end

get('/event/:id') do
  @event=Event.find(Integer(params.fetch('id')))
  erb(:event)
end

patch("/event/:id") do
  event_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  date = params.fetch("date")
  imageurl = params.fetch("imageurl")
  @event = Event.find(params.fetch("id").to_i())
  @event.update({:name => name, :date => date, :imageurl => imageurl})
  redirect("/event/#{event_id}")
end

delete("/event/:id") do
  event_id=Integer(params.fetch("id"))
  event_to_be_deleted= Event.find(event_id)
  event_to_be_deleted.destroy()
  redirect("/")
end

post ('/artist') do
  name = params.fetch('name')
  artist = Artist.create({:name => name})
  if artist.save()
    redirect ('/')
  else
    erb(:errors)
  end
end

get('/artist/:id') do
  @artist=Artist.find(Integer(params.fetch('id')))
  erb(:artist)
end

patch("/artist/:id") do
  artist_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  @artist = Artist.find(params.fetch("id").to_i())
  @artist.update({:name => name})
  redirect("/artist/#{artist_id}")
end


delete("/artist/:id") do
  artist_id=Integer(params.fetch("id"))
  artist_to_be_deleted= Artist.find(artist_id)
  artist_to_be_deleted.destroy()
  redirect("/")
end

post ('/venue') do
  name = params.fetch('name')
  address = params.fetch('address')
  imageurl = params.fetch('imageurl')
  venue = Venue.create({:name => name, :address => address, :imageurl => imageurl})
  if venue.save()
    redirect ('/')
  else
    erb(:errors)
  end
end

get('/venue/:id') do
  @venue=Venue.find(Integer(params.fetch('id')))
  erb(:venue)
end

patch("/venue/:id") do
  venue_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  address = params.fetch('address')
  imageurl = params.fetch('imageurl')
  @venue = Venue.find(params.fetch("id").to_i())
  @venue.update({:name => name, :address => address, :imageurl => imageurl})
  redirect("/venue/#{venue_id}")
end


delete("/venue/:id") do
  venue_id=Integer(params.fetch("id"))
  venue_to_be_deleted= Venue.find(venue_id)
  venue_to_be_deleted.destroy()
  redirect("/")
end

post ('/category') do
  name = params.fetch('name')
  category = Category.create({:name => name})
  if category.save()
    redirect ('/')
  else
    erb(:errors)
  end
end

get('/category/:id') do
  @category=Category.find(Integer(params.fetch('id')))
  erb(:category)
end

patch("/category/:id") do
  category_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  @category = Category.find(params.fetch("id").to_i())
  @category.update({:name => name})
  redirect("/category/#{category_id}")
end


delete("/category/:id") do
  category_id=Integer(params.fetch("id"))
  category_to_be_deleted= Category.find(category_id)
  category_to_be_deleted.destroy()
  redirect("/")
end
