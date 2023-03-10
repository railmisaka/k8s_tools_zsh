########################################
# Kubernetes Tools
#
# Context manupulation
########################################

declare -A _K8S_NAMESPACE_CLUSTER_TO_CONTEXT_MAP

function kube-change-context() {
    if [[ -z "$1" || -z "$2" ]]; then
        local _BOLD_GREEN='\033[1;32m' # bold green
        local _RESET='\033[0m'

        echo "Wrong arguments list."
        echo "Usage:"
        echo "  ${_BOLD_GREEN}$0 <project_alias> <stage>${_RESET}"
        exit 1
    fi

    local context=$_K8S_NAMESPACE_CLUSTER_TO_CONTEXT_MAP["$1=>$2"]
    if [[ -z "$context" ]]; then
        echo "Not found"
        exit 1
    fi

    echo "Switch context to:"
    echo "  $context"
    kubectl config use-context "$context"
    
    echo ""
    kube-current-context current
}

# autocomplete

_kube-change-context_keys() {
    local _kvs_raw_str="${(k)_K8S_NAMESPACE_CLUSTER_TO_CONTEXT_MAP}"
    local _kvs_array_quoted=("${(z)_kvs_raw_str}")
    local _kvs_array=("${(@Q)_kvs_array_quoted}")
    
    local _keys=()
    for i in {1..$#_kvs_array}; do
        _kv=("${(@s/=>/)_kvs_array[$i]}")
        _keys+=("$_kv[1]")
    done

    echo "$_keys[@]"
}

_kube-change-context_values() {
    local _kvs_raw_str="${(k)_K8S_NAMESPACE_CLUSTER_TO_CONTEXT_MAP}"
    local _kvs_array_quoted=("${(z)_kvs_raw_str}")
    local _kvs_array=("${(@Q)_kvs_array_quoted}")
    
    local _values=()
    for i in {1..$#_kvs_array}; do
        _kv=("${(@s/=>/)_kvs_array[$i]}")
        if [[ "$1" == "$_kv[1]" ]]; then
            _values+=("$_kv[2]")
        fi
    done

    echo "$_values[@]"
}

_kube-change-context() {
    _arguments "1:first:->first" "2:second:->second"
    case "$state" in
        first)
            local _keys=("${(z)$(_kube-change-context_keys)}")
            compadd -d _keys -a -- _keys
        ;;
        second)
            local _values=("${(z)$(_kube-change-context_values $words[2])}")
            compadd -d _values -a -- _values
        ;;
    esac
} 
 
compdef _kube-change-context kube-change-context
