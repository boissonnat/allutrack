class IndexController < ApplicationController
  def index
    if current_user
      render "private"
    else
      render "public"
    end
  end
end
