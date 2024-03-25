#!/bin/bash

# DB version passed by arg have priority
if [ "$1" ]; then
    DESIRED_DB_VERSION=$1
fi

# Exit if no DB version specified
if [ -z "$DESIRED_DB_VERSION" ]; then
    echo "No desired DB version specified"
    exit 1
fi

# Get current DB version
CURRENT_DB_VERSION=$(goose version 2>&1 | awk '{print $NF}')
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error while retrieving current DB version"
    exit $retVal
fi

# Do nothing if current version equal desired
if [ "$CURRENT_DB_VERSION" -eq "$DESIRED_DB_VERSION" ]; then
    echo "DB in desired state"
    exit 0
fi

# Upgrade if current version < desired, rollback if current version > desired
if [ "$CURRENT_DB_VERSION" -lt "$DESIRED_DB_VERSION" ]; then
    DIRECTION="up-to"
else
    DIRECTION="down-to"
fi

# Apply migrations
echo "Applying DB migrations $CURRENT_DB_VERSION $DIRECTION $DESIRED_DB_VERSION"
sleep 2
goose $DIRECTION "$DESIRED_DB_VERSION"
