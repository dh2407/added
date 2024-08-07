#!/bin/bash

# Get the directory of this script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Source the helper functions
source "$SCRIPT_DIR/helpers.sh"

# Define the input OpenAPI spec file and the generator type
INPUT_FILE="docs/openapi.yaml"
GENERATOR="typescript-axios"

# Define the output directories
PROJECT_LEVEL_DIR="./generated-api"
WEB_APP_LEVEL_DIR="./web-app/generated-api"

# Run the openapi-generator-cli command for the first output directory
if openapi-generator-cli generate -i $INPUT_FILE -g $GENERATOR -o $PROJECT_LEVEL_DIR; then
    print_green "Generation complete for project level folder ($PROJECT_LEVEL_DIR)."
else
    print_red "Generation failed for project level folder ($PROJECT_LEVEL_DIR)."
fi

# Run the openapi-generator-cli command for the second output directory
if openapi-generator-cli generate -i $INPUT_FILE -g $GENERATOR -o $WEB_APP_LEVEL_DIR; then
    print_green "Generation complete for WEB-APP level folder ($WEB_APP_LEVEL_DIR)."
else
    print_red "Generation failed for WEB-APP level folder ($WEB_APP_LEVEL_DIR)."
fi

echo "Script execution complete."
