function dev-upload
	set REGISTRY $SAM_ASSUME_ACCOUNT_ID_RABBITMQ.dkr.ecr.us-west-2.amazonaws.com
	set SRC pivotalrabbitmq/rabbitmq:$PROJECT_VERSION
	set DST $REGISTRY/amazonmq-rabbitmq:$PROJECT_VERSION
	set ITEM (jq -cn --arg vsn $PROJECT_VERSION \
'{"version":{"S":$vsn},"engineType":{"S":"RABBITMQ"},"isPubliclyAvailable":{"BOOL":true},"isInternallyAvailable":{"BOOL": true},"lockVersion":{"S": "$vsn"},"state":{"S":"PUBLIC_GA"}}')
	printf "\
Going to upload RabbitMQ docker image with following settings:
  - Env vars:
      SAM_ASSUME_ACCOUNT_ID_RABBITMQ=$SAM_ASSUME_ACCOUNT_ID_RABBITMQ
      PROJECT_VERSION=$PROJECT_VERSION
      DATA_PLANE_PROFILE=$DATA_PLANE_PROFILE
      CONTROL_PLANE_PROFILE=$CONTROL_PLANE_PROFILE
  - Source:
      $SRC
  - Target, [$DATA_PLANE_PROFILE] credentials: 
      $DST
  - BrokerEngineVersions, [$CONTROL_PLANE_PROFILE] credentials:
      $ITEM
"
	confirmN; or return 0

	aws --profile=$DATA_PLANE_PROFILE sts get-caller-identity; or return
	aws --profile=$CONTROL_PLANE_PROFILE sts get-caller-identity; or return

	aws --profile=$DATA_PLANE_PROFILE ecr get-login-password --region us-west-2 \
	| docker login --username AWS --password-stdin $REGISTRY; or return

	docker tag $SRC $DST; or return
	docker push $DST; or return

	aws --profile=$CONTROL_PLANE_PROFILE dynamodb put-item --table-name BrokerEngineVersions --item $ITEM
end
