# Rubytify

## Instructions Ayenda

- For the rubytify instructions check this gist: https://gist.github.com/AyendaRooms/235cd0955799dfc1c9ec5fa28d00f2ae 
- To upload the code create your own fork of this repo and start a pull request to this repo once you're done with your changes.

## Instructions to run localy

- Set `.env` file with the next format:
  ```
  SPOTIFY_CLIENT_SECRET=
  SPOTIFY_CLIENT_ID=
  ```
- run `bundle install`
- run `rake db:create`
- run `rake db:migrate`

## Instructions to import artists
- modify `storage/files_to_import/artists.yml` with the artists that you want import
- run `rake artists:import` this take several minutes