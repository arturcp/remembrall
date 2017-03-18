# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @collections = Collection.all

    render :index, layout: false
  end
end
