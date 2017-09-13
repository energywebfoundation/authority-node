#!/usr/bin/env bash

# Command command line parameters
while [ "$1" != "" ]; do
    case $1 in
        -n | --service-name )   shift
                                SERVICE_NAME=$1
                                ;;
        * )                    	return
    esac
    shift
done

sudo systemctl restart ${SERVICE_NAME}