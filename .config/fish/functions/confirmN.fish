function confirmN
  while true
    read -l -P 'Continue? [y/N] ' confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end
