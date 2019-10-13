desc "create artists"
task create_artists: :environment do |task, args|
   [
    "Artic Monkeys",
    "Metallica",
    "Nirvana",
    "Diomedes Diaz",
    "AC/DC",
    "311",
    "Calle 13",
    "BTS",
    "El ultimo de la fila",
    "Atercipelados",
    "Alci Acosta",
    "Green Day",
    "Tormenta",
    "Chuck Berry",
    "Joe Cuba",
    "Compay Segundo",
    "Buena Vista Social Club",
    "Masacre",
    "Pantera",
    "Ruben Blades",
    "Los Hermanos Zuleta",
    "Carlos Vives",
    "Muse",
  ].each do |artist_name|
    Artist.create_artist(name: artist_name)
  end
end