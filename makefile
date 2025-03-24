ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

run:
	docker run -p 8083:8083 --env-file aws-stepfunctions-local-credentials.txt amazon/aws-stepfunctions-local

create:
	aws stepfunctions create-state-machine \
		--endpoint-url http://localhost:8083 \
		--region us-east-1 \
		--definition file://statemachine/stock_trader.asl.json \
		--name "StockTradingLocalTesting" \
		--role-arn "arn:aws:iam::123456789012:role/DummyRole" \
		--no-cli-pager

test:
	aws stepfunctions start-execution \
		--endpoint http://localhost:8083 \
		--name StockTradingLocalTesting-1 \
		--state-machine arn:aws:states:us-east-1:123456789012:stateMachine:StockTradingLocalTesting \
		--no-cli-pager
