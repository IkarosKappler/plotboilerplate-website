#!/bin/bash

# Adds a trailing slash '/'

function ensureTrailingSlash() {
    path="$1"
    echo "$path" | sed '/\/$/! s|$|/|'
}