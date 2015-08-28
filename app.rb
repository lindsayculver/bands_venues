require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get('/') do
  @bands = Band.all()
  erb(:index)
end

post('/bands') do
  name = params.fetch("name")
  band = Band.new({:name => name, :id => nil})
  band.save()
  @bands = Band.all()
  erb(:index)
end

get('/bands/:id') do
  @band = Band.find(params.fetch("id").to_i())
  erb(:band_detail)
end

post('/bands/:id/new') do
  name = params.fetch("name")
  band_id = params.fetch("id").to_i()
  band = Band.find(band_id)
  new_venue = Venue.create({:name => name})
  band.venues.push(new_venue)
  redirect back
end

patch('/bands/:id') do
  new_name = params.fetch("name")
  id = params.fetch("id").to_i()
  @band = Band.find(id)
  @band.update({:name => new_name})
  erb(:band_detail)
end

delete('/bands/:id/delete') do
  id = params.fetch("id").to_i()
  @band = Band.find(id)
  @band.destroy()
  redirect("/")
end

get('/bands/venue/:id') do
  @venue = Venue.find(params.fetch("id").to_i())
  erb(:venue_detail)
end

get('/venue/:id') do
  @venue = Venue.find(params.fetch("id").to_i())
  @bands = Band.all()
  erb(:venue_detail)
end

post('/venue/:id') do
  band_name = params.fetch("name")
  venue_id = params.fetch("id").to_i()
  venue = Venue.find(venue_id)
  new_venue = Venue.find_or_create_by({:name => band_name})

  if band.venues().find_by({:name => band_name})
    # do nothing
  else
    band.venues.push(band_name)
  end
  redirect("/")
end

get('/band/:id') do
  @band = Band.find(params.fetch("id").to_i())
  @venues = Venue.all()
  erb(:index)
end
