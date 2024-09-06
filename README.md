# Get Plugins From All Sites
This is a quick script for zsh which allows for a plugin scan via Terminus across all WordPress sites and environments in a workspace on the Pantheon Platform.

To get started you'll need to have terminus installed and access to the Pantheon workspace you'd like to scan. The plugin levarages WP-CLI and writes a list of plugins for each environment to a text file.

## Getting Started
- Clone this repo to your development environment
- Make the script executable - chomod +x get-plugins-from-all-sites.sh
- Run the script ./get-plugins-from-all-sites

# Script Interaction
The script will prompt you for an org or workspace number in order to start scanning. There is an option to exclude sandbox sites in the plugin list scan. Frozen sites are excluded from the scan.

Please post back with any feedback you have!
