# frozen_string_literal: true

class BankedController < ApplicationController
  def index
    @text1 = 'Your payment was'
    @text2 = 'completed successfully!'
    @text3 = 'You can find your reward in your wallet'
    @deep_link = 'com.jamstaging://banked'
  end
end
