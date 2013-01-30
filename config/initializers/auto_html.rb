include	AutoHtml

AutoHtml.add_filter(:sized_image).with(:width => 200, :height => 200) do |text, options|

  text.gsub(/https?:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
    width = options[:width]
    height= options[:height]
    %|<a href="#{match}" target="_blank" class="internet_images"><img src="#{match}" alt="" width="#{width}" height="#{height}" /></a>|
  end
end