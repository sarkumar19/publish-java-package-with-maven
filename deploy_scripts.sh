#!/bin/bash

# Maven goals for building and deploying
MAVEN_GOALS="clean deploy"

# Path to the accepted and rejected directories
ACCEPTED_DIR="accepted"
REJECTED_DIR="rejected"
NOTIFICATIONS_DIR="notifications"

# Execute Maven build
mvn $MAVEN_GOALS

# Check the exit status of the Maven build
if [ $? -eq 0 ]; then
	    echo "Maven build and deployment succeeded."
    else
	        echo "Maven build or deployment failed. Moving artifacts to rejected folder and triggering notification."
		    
		    # Move artifacts to the rejected folder
		        mv target/*.jar "$REJECTED_DIR/"

			    # Trigger a notification
			        echo "Maven build or deployment failed. Reason: Your reason here." > "$NOTIFICATIONS_DIR/notification.txt"
				    
				    # Optionally, you might want to exit the script with a non-zero status to indicate failure
				        exit 1
fi

