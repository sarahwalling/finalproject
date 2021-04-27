BRANCHES_FILTER='.items[] | select(.vcs.branch != "master" and .vcs.branch != "main" ) | .vcs.branch'
PROJECT_SLUG='github/sarahwalling/finalproject'
TMP_FILE_PATH=/tmp/all_pipelines.json
PARAMETERS=$(echo '{"filler": true}' | jq .)

# getting ci pipelines
function get_ci_pipelines {
	curl --request GET \
		--url "https://circleci.com/api/v2/project/$PROJECT_SLUG/pipeline" \
		--header "Circle-Token: $CIRCLE_CI_TOKEN"
}

# gitting changed filenames "branch-name/here"
function get_changed_filenames {
	echo 'start get changed filenames'

	master="origin/master"
	branch="origin/$1"

	filenames=$(git diff $master...$branch --name-only | grep lib)

	IFS=' '
	read -r -a filenamesarr <<< "$filenames"
	echo 'looping over filenames'
	for filename in "${filenamesarr[@]}"
	do
		# use sed to isolate problem name from filename
		problemname=$(echo $filename | sed -e 's/lib\///' | sed -e 's/.rb//')
		# make the json structure
		PARAMETERS=$(echo $PARAMETERS | jq --arg pn $problemname '. + {"$pn": true}')
	 	# echo $PARAMETERS
	 	# break
	 done  
	}

# create a new pipeline, passing in the right parameters
function create_new_pipeline {
	# echo $1
	# echo $PARAMETERS
	echo 'start create new pipeline'

	PARAMETERS=$(echo $PARAMETERS | jq 'map(select(. != "filler"))')
	data=$( jq -n \
		--arg branchname "$1" \
		--arg params "$PARAMETERS" \
		'{branch: $branchname, parameters: $params}' )
	# echo $data
	echo 'curl create new pipeline'
	curl --request POST \
		--url "https://circleci.com/api/v2/project/$PROJECT_SLUG/pipeline" \
		--header "Circle-Token: $CIRCLE_CI_TOKEN" \
		--header 'Content-Type: application/json' \
		--data "\$data"
}

echo "starting"

get_ci_pipelines | jq . > $TMP_FILE_PATH
echo "got ci pipelines"
# brew install jq ???

cat $TMP_FILE_PATH | jq -c "[$BRANCHES_FILTER]" > /tmp/branch_names.json
echo "written branches to tmp file"
# returns ["branch-name", "branch-name-2"] array
branches=$(cat /tmp/branch_names.json | sed 's/\[//;s/\]//' | sed 's/"//g')
# echo "branches: $branches"


IFS=','
read -r -a branchesarr <<< "$branches"
# echo "ARRAY: $branchesarr"
for branch in "${branchesarr[@]}"
do
	# echo "BRANCH: $branch"
	get_changed_filenames $branch
	create_new_pipeline $branch
	# break
done