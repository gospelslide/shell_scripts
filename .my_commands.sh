#!/bin/zsh
function push_to_heroku() {
	git push -f $1 $2:master
	say "done"
}

function get_deployment_name() {
	kubectl get pods -n $2 | grep -m 1 "\-$1\-" | cut -d ' ' -f1
}

function pod_exec() {
	pod=$(get_deployment_name $1 $2)
	kubectl exec -it $pod -n $2 bash
}

function pod_logs() {
	pod=$(get_deployment_name $1 $2)
	kubectl logs --follow $pod -n $2
}

function get_pods() {
	kubectl get pods -n $1
}