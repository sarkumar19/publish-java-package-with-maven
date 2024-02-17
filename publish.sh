#!/bin/bash

# Set Maven Coordinates from POM file
GROUP_ID=$(xmlstarlet sel -N ns="http://maven.apache.org/POM/4.0.0" -t -v "/ns:project/ns:groupId" pom.xml)
ARTIFACT_ID=$(xmlstarlet sel -N ns="http://maven.apache.org/POM/4.0.0" -t -v "/ns:project/ns:artifactId" pom.xml)
VERSION=$(xmlstarlet sel -N ns="http://maven.apache.org/POM/4.0.0" -t -v "/ns:project/ns:version" pom.xml)

# Set GitHub Packages Repository
REPOSITORY="https://maven.pkg.github.com/pravesh-77/publish-java-package-with-maven"
USERNAME="${GITHUB_USERNAME}pravesh-77"
TOKEN="${GITHUB_TOKEN}"

# Set Paths
ARTIFACT_DIR="target"
REJECTED_DIR="rejected"

# Function to Create Rejected Directory
createRejectedDirectory() {
  mkdir -p "$REJECTED_DIR"
}

# Function to Move Artifacts to Rejected Directory
moveArtifactsToRejected() {
  mv "$ARTIFACT_DIR"/* "$REJECTED_DIR"/
}

# Function for Notification
sendNotification() {
  # Add your notification logic here (e.g., sending an email, logging, etc.)
  echo "Publishing failed. Artifacts moved to the rejected folder."
}

# Maven Publish
mvn deploy:deploy-file \
  -DgroupId="$GROUP_ID" \
  -DartifactId="$ARTIFACT_ID" \
  -Dversion="$VERSION" \
  -Durl="$REPOSITORY" \
  -DrepositoryId=github \
  -Dfile="$ARTIFACT_DIR"/"$ARTIFACT_ID"-"$VERSION".war \
  -DpomFile="$ARTIFACT_DIR"/"$ARTIFACT_ID"-"$VERSION".pom \
  -Dpackaging=war \
  -DgeneratePom=true \
  -DgeneratePom.description="GitHub Packages"

# Check Maven Exit Code
if [ $? -eq 0 ]; then
  echo "Publishing successful."
else
  echo "Publishing failed."
  createRejectedDirectory
  moveArtifactsToRejected
  sendNotification
fi
