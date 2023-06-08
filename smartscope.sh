#! /bin/bash

helpText () {
    OPTIONS="
Usage: $(basename $0) \e[3msubcommand [command]\e[0m

Subcommand              DESCRIPTION
==========              ===========
start                   Start SmartScope
stop                    Stop smartscope
run \e[3mcommand\e[0m             Run a smartscope command in the smartscope container
python                  Runs an interactive ipython shell inside the smartscope container
"
    echo -e "$OPTIONS"
}

[ -n "$1" ] && argument=$1 || {
    helpText
    exit 1
}
cd $(dirname "$(readlink -f "$0")")


app=SmartScope
case $argument in
    start)
        echo "Create and run ${app} containers:"
        docker compose up -d ;;
    stop)
        echo "Stop ${app} containers:"
        docker compose down ;;
    clear)
        echo "Remove all remaining files when building containers:"
        rm -fr db/*
        rm -fr shared/nginx/*
        rm -fr shared/smartscope/*;;
    run)
        cmd="docker exec smartscope smartscope.py ${@:2}"
        echo -e "Execute command inside the ${app} containers: \e[3m$cmd\e[0m"
        exec $cmd;;
    help|-h|--help)
        helpText;;
    python)
        echo "Run python shell inside the container smartscope (Django project)"
        docker exec -it smartscope manage.py shell -i ipython ;;
    *)
        echo Unkown command error: $argument
        helpText
        exit 1;;
esac
