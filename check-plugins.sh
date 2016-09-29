host=$1
curl ${host}/openspecimen/rest/ng/config-settings/app-props | jq -r '.plugins'