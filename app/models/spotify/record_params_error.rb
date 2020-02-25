# frozen_string_literal: true

module Spotify
  class RecordParamsError < StandardError
    def initialize(record)
      super("Incomplete params to create #{record}")
    end
  end
end
