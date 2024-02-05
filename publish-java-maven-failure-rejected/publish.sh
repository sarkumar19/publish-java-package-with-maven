#!/bin/bash

# Maven deploy
mvn deploy -DskipTests || { 
	    echo "Maven deployment failed. Moving artifacts to Rejected directory."
    mv target/*.jar Rejected/
        exit 1
}

