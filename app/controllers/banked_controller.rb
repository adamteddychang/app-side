# frozen_string_literal: true

class BankedController < ApplicationController
  def index
    @text1, @text2, @text3 =  ['Your payment was', 'completed successfully!', 'You can find your reward in your wallet']
    @deep_link = 'com.jamstaging://banked'
  end
end
