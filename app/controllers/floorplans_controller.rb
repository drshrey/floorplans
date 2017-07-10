require 'aws-sdk'
require 'mini_magick'
require 'uri'

class FloorplansController < ApplicationController
  def create
    Aws.config = {
        :region => 'us-east-2'
    }

    # check if Floorplan obj already exists with
    ## corresponding filename and project_id
    s3 = Aws::S3::Resource.new
    split_arr = floorplan_params[:blueprint].split(';')
    content_type = split_arr[0].split(':')[-1]
    body = Base64.decode64(floorplan_params[:blueprint].split(',')[1])

    time = Time.now.to_i.to_s
    filepath = floorplan_params[:filepath].split("\\")[-1]

    amazon_obj = s3.bucket('fieldwireapp').object(time + filepath).put(
      body: body, acl: 'public-read', content_type: content_type, content_encoding: 'base64')

    s3_url = "https://fieldwireapp.s3.amazonaws.com/" + time + filepath
    # floorplan_params = floorplan_params.merge({"s3_url" => s3_url, "filepath" => filepath })

    @existing_floorplan = Floorplan.find_by project_id: floorplan_params[:project_id], filepath: filepath
    if @existing_floorplan != nil
      @existing_floorplan.update(filepath: filepath)
      @existing_floorplan.update(s3_url: s3_url)
      render json: { "status" => "Updated", "floorplan" => @existing_floorplan }
    else
      params = {
        "display_name" => floorplan_params[:display_name],
        "blueprint" => floorplan_params[:blueprint],
        "project_id" => floorplan_params[:project_id],
        "s3_url" => s3_url,
        "filepath" => filepath
      }

      @floorplan = Floorplan.new(params)
      if @floorplan.save
        render json: @floorplan
      else
        render json: @floorplan.errors, status: :unprocessable_entity
      end
    end
  end

  private
  def floorplan_params
    params.require(:floorplan).permit(:display_name, :blueprint, :project_id, :filepath)
  end
end
