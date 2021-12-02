function wav2ogg
    rename -z *.wav
    and for file in *.wav
        set target (echo "$file" | cut -d'.' -f1 | tr ' ' '-').ogg
        ffmpeg -i $file -c:a libopus -b:a 96000 -vsync 2 $target
    end
end
