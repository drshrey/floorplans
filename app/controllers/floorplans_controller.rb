require 'aws-sdk'
require 'mini_magick'
require 'uri'

class FloorplansController < ApplicationController
  def show
    @floorplan = Floorplan.find_by_id(params[:id])
    @versioned_files = @floorplan.versioned_files
  end

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

    s3.bucket('fieldwireapp').object(time + filepath).put(
      body: body, acl: 'public-read', content_type: content_type, content_encoding: 'base64')

    # handle thumb and large images
    s3_url = URI.escape("https://fieldwireapp.s3.amazonaws.com/" + time + filepath)
    image = MiniMagick::Image.open(s3_url)

    thumb_image = image
    thumb_image.resize "100x100"
    thumb_image.format "png"

    large_image = image
    large_image.resize "2000x2000"
    large_image.format "png"

    s3.bucket('fieldwireapp').object("thumb" + time + filepath).put(
      body: thumb_image.to_blob, acl: 'public-read', content_type: "images/png", content_encoding: 'base64')
    s3.bucket('fieldwireapp').object("large" + time + filepath).put(
      body: large_image.to_blob, acl: 'public-read', content_type: "images/png", content_encoding: 'base64')

    thumb_url = "https://fieldwireapp.s3.amazonaws.com/thumb" + time + filepath
    large_url = "https://fieldwireapp.s3.amazonaws.com/large" + time + filepath

    @existing_floorplan = Floorplan.find_by project_id: floorplan_params[:project_id], filepath: filepath
    if @existing_floorplan != nil
      puts "updating existing file!"
      # create new versioned file
      new_versioned_file_params = {
        "filename" => filepath,
        "s3_url" => s3_url,
        "thumb_image_url" => thumb_url,
        "large_image_url" => large_url,
        "floorplan_id" => @existing_floorplan.id,
        "version_number": @existing_floorplan.versioned_files.size + 1
      }

      @new_versioned_file = VersionedFile.new(new_versioned_file_params)
      if @new_versioned_file.save
        render json: {
          "status" => "Updated",
          "floorplan" => @existing_floorplan,
          "versioned_file" => @new_versioned_file
        }
      else
        render json: @new_versioned_file.errors, status: :unprocessable_entity
      end
    else
      params = {
        "display_name" => floorplan_params[:display_name],
        "blueprint" => floorplan_params[:blueprint],
        "project_id" => floorplan_params[:project_id],
        "filepath" => filepath,
      }

      @floorplan = Floorplan.new(params)

      if @floorplan.save
        versioned_file_params = {
          "filename" => filepath,
          "s3_url" => s3_url,
          "thumb_image_url" => thumb_url,
          "large_image_url" => large_url,
          "floorplan_id" => @floorplan.id,
          "version_number": @floorplan.versioned_files.size + 1
        }

        @versioned_file = VersionedFile.new(versioned_file_params)

        if @versioned_file.save
          @floorplan.reload
          render json: {
              "status": "Added",
              "floorplan": @floorplan,
              "versioned_file": @versioned_file
          }
        else
          render json: @versioned_file.errors, status: :unprocessable_entity
        end
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
