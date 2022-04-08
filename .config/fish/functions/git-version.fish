function git-version
	set timestamp (date +'%Y%m%d%H%M%S')
	git describe --dirty --abbrev=7 --tags --always --first-parent | \
	sed -e "s/^rabbitmq_v//" -e "s/^v//" -e "s/_/./g" -e "s/-/+/" \
	 -e "s/-/./g" -e "s/+/-/" -e "s/.dirty/.dirty+$timestamp/"; \
end
