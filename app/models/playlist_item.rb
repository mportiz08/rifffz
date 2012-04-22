# encoding: utf-8

module Rifffz
  class PlaylistItem < ActiveRecord::Base
    belongs_to :playlist
    belongs_to :song
  end
end
