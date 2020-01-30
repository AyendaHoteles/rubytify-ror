# Rubytify Ayenda Code Challenge

## Production: API Usage

The API consists in 4 endpoints:
### Endpoint 1 list all available artists on the server ranked by popularity
**Method: GET**

**URL:**
```
http://rubytify-mferrerisaza.herokuapp.com/api/v1/artists
```

**Example Request**
```
curl -X GET http://rubytify-mferrerisaza.herokuapp.com/api/v1/artists
```
**Example Response**

```json
{
    "data": [
        {
            "id": 9,
            "name": "BTS",
            "image": "https://i.scdn.co/image/0c9057cb30520f9f883a220051260fc66a2f3ffa",
            "genres": [
                "k-pop",
                "k-pop boy group"
            ],
            "popularity": 94,
            "spotify_url": "https://open.spotify.com/artist/3Nrfpe0tUJi4K4DXYWgMUX"
        },
        {
            "id": 3,
            "name": "Arctic Monkeys",
            "image": "https://i.scdn.co/image/ed0552e9746ed2bbf04ae4bcb5525700ca31522d",
            "genres": [
                "garage rock",
                "modern rock",
                "permanent wave",
                "rock",
                "sheffield indie"
            ],
            "popularity": 86,
            "spotify_url": "https://open.spotify.com/artist/7Ln80lUS6He07XvHI8qqHH"
        }
   ]
}
```
### Endpoint 2 list all albums of a specific artist
**Method: GET**

**URL:**
```
http://rubytify-mferrerisaza.herokuapp.com/api/v1/artists/:artist_id/albums
```
where `:artist_id` is the id on the server for the artist you want to list all albums.

**Example Request**
```
curl -X GET http://rubytify-mferrerisaza.herokuapp.com/api/v1/artists/22/albums
```
**Example Response**

```json
{
    "data": [
        {
            "id": 437,
            "name": "Indira II",
            "image": "https://i.scdn.co/image/ab67616d0000b273f3d5b2872d7cf0d23e3db92b",
            "spotify_url": "https://open.spotify.com/album/3IcC5W9kdTrRzwC4Xa4K21",
            "total_tracks": 1
        },
        {
            "id": 436,
            "name": "Clásicos de la Provincia",
            "image": "https://i.scdn.co/image/ab67616d0000b2738e4dceb569a5020a45a7d116",
            "spotify_url": "https://open.spotify.com/album/3mg8UDN3X1gfebVI3OV5AU",
            "total_tracks": 15
        }
   ]
}
```
### Endpoint 3 list all songs of a specific album
**Method: GET**

**URL:**
```
http://rubytify-mferrerisaza.herokuapp.com/api/v1/albums/:album_id/songs
```
where `:album_id` is the id on the server for the album you want to list all songs.

**Example Request**
```
curl -X GET http://rubytify-mferrerisaza.herokuapp.com/api/v1/albums/417/songs
```
**Example Response**

```json
{
    "data": [
        {
            "name": "El Parana",
            "spotify_url": "https://open.spotify.com/track/1yY7bLdPBaGR8X4HMKkU7x",
            "preview_url": "https://p.scdn.co/mp3-preview/5c435081f5e7db450ecb42783c3d561314bb4a6a?cid=63c06b9a8c4147b7b5435eabe9b6f648",
            "duration_ms": 179311,
            "explicit": false
        },
        {
            "name": "Come El Macao Candela",
            "spotify_url": "https://open.spotify.com/track/1erpVkLid4dv3JIevAq1Bn",
            "preview_url": "https://p.scdn.co/mp3-preview/65b95bf47bd49189a89b05cf703d6300f0dc3944?cid=63c06b9a8c4147b7b5435eabe9b6f648",
            "duration_ms": 181759,
            "explicit": false
        }
   ]
}
```
### Endpoint 4 return a random song from a specific album
**Method: GET**

**URL:**
```
https://rubytify-mferrerisaza.herokuapp.com/api/v1/genres/:genre_name/random_song
```
where `:genre_name` is the name of the genre you want a random song from.

**Example Request**
```
curl -X GET https://rubytify-mferrerisaza.herokuapp.com/api/v1/genres/vallenato/random_song
```
**Example Response**

```json
{
    "data": {
        "name": "Fruta Fresca - En Vivo Desde el Estadio El Campín de Bogotá",
        "spotify_url": "https://open.spotify.com/track/7y3adPdCrG2wWhXx0MLSGq",
        "preview_url": "https://p.scdn.co/mp3-preview/c7d7365233e98e6b49d302f9e14412bd02c2061e?cid=63c06b9a8c4147b7b5435eabe9b6f648",
        "duration_ms": 404693,
        "explicit": false
    }
}
```
## Import on Production
To import the data from the spotify API, I choose to implement 3 jobs: one for artists, other for albums and another for songs, I choose a Job because it retries when the spotify api returns too many requests error, and because it does not use the main app process, and you can still use the api while importing data from spotify.

In order to enqueue the info to download to the  jobs you must execute the following rake tasks on the server, following this order and waiting until the job ends importing the data before going to the next task :

  1. For the artists import `rails import_from_spotify:artists`
  2. Once the artists are store in the db (check the progress on the import  at `https://rubytify-mferrerisaza.herokuapp.com/sidekiq/`)  run `rails import_from_spotify:albums`
  3. Once the albums are store in the db you can run `rails import_from_spotify:tracks`

You could enqueue the AlbumsImportJob from the ArtistsImportJob and so on in case you want to only running a task, but I choose not to at the moment.

## Development
* Clone this repository.
* Ensure you have `ruby 2.6.2` installed on your machine.
* Run `gem install bundler`.
* Run `bundle install`.
* Run `bundle excec rails db:create && bundle exec rails db:migrate`.
* Run `bundle excec rails server` and you are all set to start recieving requests on `http://localhost:3000/`.
* Ensure you have `redis` install
* Run `bundle excec sidekiq`
* With a sidekiq process running you can run the rake tasks to import records from the spotify api:
  1. For the artists import `rails import_from_spotify:artists`
  2. Once the artists are store in the db (check the progress on your server at `/sidekiq`) you can run `rails import_from_spotify:albums`
  3. Once the albums are store in the db you can run `rails import_from_spotify:tracks`
* If you want to run the tests locally just run `bundle exec rspec`.
