# frozen_string_literal: true

module Spotify
  class ResourcesData
    def first_image(record)
      record.images.first ? record.images.first['url'] : ''
    end

    def spotify_artists
      %w[
        Artic_Monkeys
        Metallica
        Nirvana
        Diomedes_Diaz
        AC/DC
        311
        Calle_13
        BTS
        El_ultimo_de_la_fila
        Atercipelados
        Alci_Acosta
        Green-Day
        Tormenta
        Chuck_Berry
        Joe_Cuba
        Compay_Segundo
        Buena_Vista_Social_Club
        Masacre
        Pantera
        Ruben_Blades
        Los_Hermanos_Zuleta
        Carlos_Vives
        Muse
      ].freeze
    end
  end
end
