module DashboardHelper

  #A color acording to the achieved percentage
  def rgb_values(percentage)
    percentage = 0 if percentage.nil?
    # 255 is a strongly unpleasant color in most browsers
    g=(225*percentage)/100
    r=(225*(100-percentage))/100;
    b=0
    "rgb(#{r}, #{g}, #{b})"
  end

end
