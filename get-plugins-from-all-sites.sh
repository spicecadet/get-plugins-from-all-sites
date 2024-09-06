#!/bin/zsh

echo "*******************************************************************"
echo "This script gets all plugins from all environments in an account."
echo "Frozen sites are ignored by default."
echo "*******************************************************************"

vared -p "Enter a Pantheon Org ID: " -c ORG 
vared -p "Would you like to include Sandbox sites? (Enter yes or no): " -c SANDBOX_SITES

# This file will be written to with plugin list output
PLUGINLIST="plugins-$ORG.txt"
ENV_ARRAY=()

echo "\nGot it. Hang tight.\nI'm going to search through sites in $ORG"

if [[ $SANDBOX_SITES == "no" ]]
then
	echo "Sandbox sites are being excluded"
	SITES=$(eval terminus org:site:list ${ORG} --field=name --filter field=plan_name!=Sandbox&&frozen="")
else
	echo "Sandbox sites are being included"
	SITES=$(eval terminus org:site:list ${ORG} --field=name --filter frozen="")
fi

# Create an array of sites from the SITES string
SITES_ARRAY=( ${=SITES} )

# Clear the plugin list file before populating
: > $PLUGINLIST

echo "\n*******************************************************************"
echo "Getting environments for Org: $ORG"
echo "*******************************************************************"

for env in ${SITES_ARRAY} 
do

# Get all site environments
ENV_ARRAY+=$(terminus env:list ${env} --field=id --filter initialized=1 | xargs -I {} echo "${env}.{}")
echo $env

done

echo "\n*******************************************************************"
echo "Getting plugins for all environments"
echo "*******************************************************************\n"

for site in $ENV_ARRAY
do

echo "***** ${site} *****" >> $PLUGINLIST
terminus wp -- ${site} plugin list --field=name >> $PLUGINLIST
echo "**************************\n" >> $PLUGINLIST
echo "\n"

done

echo "*******************************************************************"
echo "Plugin lists for each environment have been written to:"
echo $PLUGINLIST 
echo "*******************************************************************"
