# Rubytify

## Instructions

- For the rubytify instructions check this gist: https://gist.github.com/AyendaHoteles/235cd0955799dfc1c9ec5fa28d00f2ae 
- To upload the code create your own fork of this repo and start a pull request to this repo once you're done with your changes.

This is a skill tests for ayenda.com developed by Harold Mideros

- To run the project you must be run the follow commands

- <code> $ rails db:drop db:create db:migrate</code>
- <code> $ rails server </code>


- To populate database with information from spotify, you need api credentials from https://developer.spotify.com/dashboard.

- <code>$ rails credentials:edit</code>

and put your api spotify credentias as bellow

```ruby
spotify:
  client_id: <your_client_id>
  client_secret: <your_client_secret>
```

finally you can execute the rake task
- <code>$ rails fetch:spotify</code>