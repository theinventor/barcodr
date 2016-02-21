class SignaturesController < ApplicationController
  def index
    render text: 'Send us some jquery signature pad data to /signatures/:data'
  end

  def create
    respond_to do |format|
          format.html {}
          format.pdf { prawnto :prawn=>{page_size: [pdf_width, base_height], margin: [1,1,1,1]} }
          format.png {
            path = "#{Rails.root}/tmp/signature.png"
            instructions = JSON.load(params[:id]).map { |h| "line #{h['mx']},#{h['my']} #{h['lx']},#{h['ly']}" } * ' '
            system "convert -size 400x110 xc:transparent -stroke blue -draw '#{instructions}' #{path}"
            send_data image, :type => 'image/png', :disposition => 'inline'
          }
        end
  end
end
