function avatar -a input
    convert $input \
        # replace alha with color
        -gravity Center -background '#99cccd' -flatten \
        # pixelate
        -scale 41x \
        # cut out a circle
        \( +clone -threshold 101% -fill white -draw 'circle 20 20 20 2' \) \
        -channel-fx '| gray=>alpha' \
        # sharpen pixels
        -scale 656x avatar.png
end
