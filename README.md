# A bit of tools for ```kubectl```

Simple zsh aliases and functions set for ```kubectl```.

## Setup

```(zsh)
git clone https://github.com/railmisaka/k8s_tools_zsh.git .k8s_tools_zsh

echo "K8S_TOOLS_ZSH_DIR=~/.k8s_tools_zsh" > ~/.zshrc
echo "source ~/.k8s_tools_zsh/source.zshrc" > ~/.zshrc
```

## List of functions

* ```k``` &rArr; ```kubectl```

* ```kctx c``` &rArr; shows information about currect kubectl context

* ```kctx l``` &rArr; shows list of kubectl contexts

* ```kc <project> <stage>``` &rArr; for cnahge kubectl context (see settings of this command in section ['setup your projects'](#setup-your-projects) below).

## Setup your projects

To use context change operation autocomplete make a file ```.cluster.zshrc``` with content like this:

```(plaintext)
_K8S_NAMESPACE_CLUSTER_TO_CONTEXT_MAP["<project>=><stage>"]="<context>"
_K8S_NAMESPACE_CLUSTER_TO_CONTEXT_MAP["ProjectX=>production"]="project-x-production-context"
```

And add it your ```.zshrc``` file:

```(zsh)
echo "source ~/.roc.zshrc"  > ~/.zshrc
```

Now this will activate context with name ```project-x-production-context```.

```(zsh)
kc ProjectX production
```
