class BarcodesController < ApplicationController
  before_filter :allow_iframe_requests

  def index
  end

  def show
    base_width = 100
    base_height = 60
    if params[:id]
      pdf_width = base_width + (params[:id].length * 10)
    end
    @barcode_data = params[:id]
    respond_to do |format|
      format.html {}
      format.pdf { prawnto :prawn=>{page_size: [pdf_width, base_height], margin: [1,1,1,1]} }
      format.png {
        barcode = Barby::Code128B.new(params[:id])
        send_data barcode.to_png(height: 50, margin: 0), :type => 'image/png', :disposition => 'inline'
      }
    end

  end
end
