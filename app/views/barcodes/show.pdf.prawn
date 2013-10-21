require 'prawn/layout'

  code_text = "*#{@barcode_data}*"
  font_path = "app/fonts/3of9.ttf"
  font_path = "#{Rails.root}/app/fonts/3of9.ttf" if Rails.env.development?
  pdf.move_down 15

  pdf.font font_path do
    size = 36
    pdf.text code_text, size: size
  end

