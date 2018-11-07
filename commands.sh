#!/usr/bin/env bash

# Simplifies running matlab from the command line. Slow though.
function mlb() {
    echo "Trying to run ${1}"
    matlab -nodisplay -nosplash -nodesktop -r "try, run('${1}'), catch me, fprintf('%s / %s\n',me.identifier, me.message), end, exit;"
}

