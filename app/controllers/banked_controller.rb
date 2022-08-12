# frozen_string_literal: true

class BankedController < ApplicationController
  def index
    @deep_link = "com.jamstaging://banked"
  end
end
