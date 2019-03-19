class DepreciationController < ApplicationController
  def index
    @goods = Good.active
  end
end
