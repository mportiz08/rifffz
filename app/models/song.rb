module Rifffz
  class Song < ActiveRecord::Base
    belongs_to :album
  end
end
