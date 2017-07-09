class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def show
    begin
      @project = Project.find_by_id(params[:id])
      @floorplans = @project.floorplans
    rescue ActiveRecord::RecordNotFound => e
      puts @e
      render json: @e
    end
  end

  private
  def project_params
    params.require(:project).permit(:title)
  end
end
