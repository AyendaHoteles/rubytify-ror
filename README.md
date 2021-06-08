# Rubytify
[rubytify_image](https://www.canva.com/design/DAEgdZMOINk/FZCEl77YOD8HJw9zIOZ6sg/view?utm_content=DAEgdZMOINk&utm_campaign=designshare&utm_medium=link&utm_source=publishsharelink)

Rubytify is an API that fetch info from the Spotify API and serve its over this Rails REST API.


## Requirements
Ruby 2.6.3
Rails 5.2.3


## Endpoints

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

Check the app live in Heroku here [App Link]()



`Made with 💛  by Nathaly Sotomayor Ampudia 👩🏻‍💻`

