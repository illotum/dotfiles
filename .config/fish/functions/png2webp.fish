function png2webp
    rename -z *.png
    and mogrify -format webp *.png
end
