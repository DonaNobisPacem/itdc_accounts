class BasePdf < Prawn::Document
  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  TABLE_FONT_SIZE = 9
  TABLE_BORDER_STYLE = :grid

  def initialize(default_prawn_options={})
    super(default_prawn_options)
    font_size 10
  end

  def header(title=nil, subtitle=nil)
    #image "#{Rails.root}/public/logo.png", height: 30
    #text "My Organization", size: 18, style: :bold, align: :center
    if title
      text title, size: 12, style: :bold, align: :center
      if subtitle
        text subtitle, size: 12, style: :bold, align: :center
      end
      text "As of #{Time.now.strftime("%^b-%d-%Y %H:%M")}", size: 12, style: :bold_italic, align: :center
    end
  end

  def footer
  end

  def ntc(amount)
    ActiveSupport::NumberHelper.number_to_currency(amount, unit: "P")
  end
end