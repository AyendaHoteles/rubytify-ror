# Rubytify

## Instructions

- For the rubytify instructions check this gist: https://gist.github.com/AyendaHoteles/235cd0955799dfc1c9ec5fa28d00f2ae 
- To upload the code create your own fork of this repo and start a pull request to this repo once you're done with your changes.

## Installation
  install gems
```bash
bundle
```
  run migrations
```bash
rails db:migrate
```

  run task for import data from spotify 
```bash
rake imported:import_data_spotify
```
  run project 
```bash
rails s
```
