[[ -f "$HOME/.docker-completion.bash" ]] && source "$HOME/.docker-completion.bash"
[[ -f "$HOME/.docker-machine-completion.bash" ]] && source "$HOME/.docker-machine-completion.bash"

export DOCKER_MACHINE_WRAPPED="true"
[[ -f "$HOME/.docker-machine-wrapper.bash" ]] && source "$HOME/.docker-machine-wrapper.bash"
eval $(docker-machine env)
