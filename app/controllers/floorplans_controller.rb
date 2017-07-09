class FloorplansController < ApplicationController
  def create
    @floorplan = Floorplan.new(floorplan_params)
    if @floorplan.save
      render json: @floorplan
    else
      render json: @floorplan.errors, status: :unprocessable_entity
    end
  end

  private
  def floorplan_params
    params.require(:floorplan).permit(:display_name, :blueprint, :project_id)
  end
end
