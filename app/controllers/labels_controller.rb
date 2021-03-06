class LabelsController < ApplicationController
  before_filter :allow_iframe_requests

  def index
  end

  def show
    base_width = params[:width] || 300
    base_height = params[:height] || 100

    base_width = base_width.to_i
    base_height = base_height.to_i
    # if params[:id]
    #   pdf_width = base_width + (params[:id].length * 10)
    # end
    @barcode_data = params[:id]
    @line1 = params[:line1]
    @line2 = params[:line2]
    @line3 = params[:line3]
    @line4 = params[:line4]

    respond_to do |format|
      format.html {}
      format.pdf {
        prawnto :prawn=>{page_size: [base_width, base_height], margin: [10,10,10,10]}
        }
      format.png {
        render text: "Not available"
      }
    end

  end
end
