########################################
# Kubernetes Tools
#
# Information about context
########################################

function _k8s_current_context() {
    local _BOLD_RED='\033[1;31m'   # bold red
    local _BOLD_GREEN='\033[1;32m' # bold green
    local _RESET='\033[0m'

    echo "Current context:"
    echo "  Cluster:\t${_BOLD_RED}$(kubectl config view --minify -o jsonpath='{..context.cluster}')${_RESET}"
    echo "  Namespace:\t${_BOLD_GREEN}$(kubectl config view --minify -o jsonpath='{..context.namespace}')${_RESET}"
    echo "  User:\t\t$(kubectl config view --minify -o jsonpath='{..context.user}')"
    echo "  Context name:\t$(kubectl config view --minify -o jsonpath='{..current-context}')"
}

function _k8s_contexts_list() {
    kubectl config get-contexts
}

function kube-current-context() {
    case ${1} in
    
    c) _k8s_current_context ;;
    cur) _k8s_current_context ;;
    current) _k8s_current_context ;;

    l) _k8s_contexts_list ;;
    ls) _k8s_contexts_list ;;
    list) _k8s_contexts_list ;;

    *)
        echo "Unknown parameter value '$1'; use autocomplete."
        exit 1
    ;;
    esac
}

# autocomplete

_kube-current-context() { 
  compadd c cur current l ls list
} 
 
compdef _kube-current-context kube-current-context
