require 'prawn/layout'

  code_text = "*#{@barcode_data}*"
  font_path = "app/fonts/code128.ttf"
  font_path = "#{Rails.root}/app/fonts/code128.ttf" if Rails.env.development?

  pdf.font font_path do
    size = 40
    pdf.text code_text, size: size
  end

