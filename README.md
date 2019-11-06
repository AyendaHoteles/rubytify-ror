# Rubytify

Created by Mauricio Barros
mail: cmbarrososorio@gmail.com

ruby v2.6.2

Importer:

- The importer task populates the database by ARTIST, which means it fetches albums and songs accordingly (ARTIST has many ALBUMS, ALBUM has many SONGS), so joined queries work.
- When querying the albums from the external API, Spotify returned many duplicates so I decided to implement the algorithm to fetch ONLY unique named ALbums by each Artist to reduce trash/duplicated data and improve efficiency.
- I noticed Spotify doesn't have preview URLs for every song fetched, so a few of them have nil preview_url's
- Used figaro gem to store my Spotify credentials in ENV keys, therefore...
- To run the task locally: Replace SPOTIFY_CLIENT_ID and SPOTIFY_CLIENT_SECRET in config/application.rb with valid Spotify Dev Credentials


Deployment:

- Heroku kept returning several errors when building the repo and I wasn't able to deploy it
rubytify-challenge.herokuapp.com

- The steps I followed were:
  1. Install heroku
  2. Move sqlite3 gem to development and test group
  3. Move pg gem to production group and run bundle
  4. Run ssh-keygen -t rsa and Heroku keys:add on terminal
  5. Run heroku login and heroku create on terminal
  6. git push heroku master
