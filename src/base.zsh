#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function fzf::exist {
    if ! type -p fzf > /dev/null; then
        echo 0
        return
    fi
    echo 1
}

function ripgrep::exist {
    if ! type -p rg > /dev/null; then
        echo 0
        return
    fi
    echo 1
}

function assh::exist {
    if ! type -p assh > /dev/null; then
        echo 0
        return
    fi
    echo 1
}

function jq::exist {
    if ! type -p jq > /dev/null; then
        echo 0
        return
    fi
    echo 1
}

function brew::exist {
    if ! type -p brew > /dev/null; then
        echo 0
        return
    fi
    echo 1
}

function nvm::exist {
    if ! type nvm > /dev/null; then
        echo 0
        return
    fi
    echo 1
}

function node::exist {
    if ! type -p node > /dev/null; then
        echo 0
        return
    fi
    echo 1
}

function mosh::exist {
    if ! type -p mosh > /dev/null; then
        echo 0
        return
    fi
    echo 1
}


function jq::install {
    if [ "$(brew::exist)" -eq 0 ]; then
        message_warning "${SSH_MESSAGE_BREW}"
        return
    fi
    brew install jq
}

function fzf::install {
    if [ "$(brew::exist)" -eq 0 ]; then
        message_warning "${SSH_MESSAGE_BREW}"
        return
    fi
    brew install fzf
}

function ripgrep:install {
    if [ "$(brew::exist)" -eq 0 ]; then
        message_warning "${SSH_MESSAGE_BREW}"
        return
    fi
    brew install ripgrep
}


function nvm::install {
    if [ "$(nvm::exist)" -eq 0 ]; then
        message_warning "${SSH_MESSAGE_NVM}"
        return
    fi
}

function node::install {
    if [ "$(nvm::exist)" -eq 1 ]; then
        nvm install lts
        return
    fi
    message_warning "${SSH_MESSAGE_NVM}"
}

function mosh::install {
    if [ "$(brew::exist)" -eq 0 ]; then
        message_warning "${SSH_MESSAGE_BREW}"
        return
    fi
    brew install mosh
}


# assh::install - install assh
function assh::install {
    if [ "$(brew::exist)" -eq 0 ]; then
        message_warning "${SSH_MESSAGE_BREW}"
        return
    fi
    brew install assh
}

if [ "$(fzf::exist)" -eq 0 ]; then fzf::install; fi
if [ "$(jq::exist)" -eq 0 ]; then jq::install; fi
if [ "$(nvm::exist)" -eq 0 ]; then nvm::install; fi
if [ "$(node::exist)" -eq 0 ]; then node::install; fi
if [ "$(ripgrep::exist)" -eq 0 ]; then ripgrep:install; fi
if [ "$(mosh::exist)" -eq 0 ]; then mosh::install; fi
if [ "$(assh::exist)" -eq 0 ]; then assh::install; fi

if ! type -p rg > /dev/null; then
    # Setting rg as the default source for fzf
    export FZF_DEFAULT_COMMAND='rg --files'

    # Apply the command to CTRL-T as well
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

function ssh::path::linux {
    # shellcheck source=/dev/null
    source "${SSH_SOURCE_PATH}"/linux.zsh
}

function ssh::path::osx {
    # shellcheck source=/dev/null
    source "${SSH_SOURCE_PATH}"/osx.zsh
}

function ssh::path::factory {
    case "${OSTYPE}" in
        darwin*)
            ssh::path::osx
            ;;
        linux*)
            ssh::path::linux
            ;;
    esac
}

ssh::path::factory