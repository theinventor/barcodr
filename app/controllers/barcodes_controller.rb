class BarcodesController < ApplicationController
  def index
  end

  def show
    base_width = 100
    if params[:id]
      pdf_width = base_width + (params[:id].length * 12)
    end
    @barcode_data = params[:id]
    temp_data = @barcode_data
    respond_to do |format|
      format.html {}
      format.pdf { prawnto :prawn=>{page_size: [pdf_width || 200,30], margin: [1,1,1,1]} }
      format.jpg {
        template = File.read("#{Rails.root}/app/views/barcodes/show.pdf.prawn")
            pdf = Prawn::Document.new(page_size: [pdf_width || 200,30], margin: [1,1,1,1])
            pdf.instance_eval do
              @barcode_data = temp_data
              eval(template) #this evaluates the template with your variables
            end
            the_file = pdf.render
        file_name = "#{Rails.root}/tmp/#{params[:id]}.pdf"
        File.open(file_name, 'w:ASCII-8BIT') do |f|
          f.write the_file
        end
        require 'RMagick'
        im = Magick::Image.read(file_name)
        im[0].write(file_name + ".jpg"){ self.quality = 90 }
        send_data File.read("#{file_name}.jpg"), :type => 'image/jpeg', :disposition => 'inline'
      }
    end

  end
end
