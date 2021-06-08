# Rubytify
![rubytify_image](https://user-images.githubusercontent.com/28455356/121103707-14b83280-c7c6-11eb-8c54-bc07770f5a8b.png)


Rubytify is an API that fetch info from the Spotify API and serve its over this Rails REST API.


## Requirements

* Ruby 2.6.3
* Rails 5.2.3


## API Endpoints

* The endpoint `/api/v1/artists` return all artists ordered by their popularity with the following fields:

```
 · id
 · name
 · image
 · genres
 · popularity
 · spotify_url
```


* The endpoint `/api/v1/artists/:id/albums` return all albums for an artist with the following fields:

```
 · id
 · name
 · image
 · spotify_url
 · total_tracks
```

* The endpoint `/api/v1/albums/:id/songs` return all songs for an album with the following fields:

```
 · name
 · spotify_url
 · preview_url
 · duration_ms
 · explicit
```

* The endpoint `/api/v1/genres/:genre_name/random_song` should return a random song that matches the specified genre. The response contain the following fields:

```
 · name
 · spotify_url
 · preview_url
 · duration_ms
 · explicit
```


## App Live Demo

Check the app live in Heroku here [App Link](https://rubytify-api-nathsotomayor.herokuapp.com/api/v1/artists)



`Made with 💛  by Nathaly Sotomayor Ampudia 👩🏻‍💻`

