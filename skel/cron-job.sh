
RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RESET=`tput sgr0`

cd ${XPATH}

# fetch changes, git stores them in FETCH_HEAD
git fetch

DATE=$(date)

# check for remote changes in origin repository
newUpdatesAvailable=$(git diff HEAD FETCH_HEAD)
if [ "${newUpdatesAvailable}" != "" ]
then
        echo "${RED}[!] ${GREEN}Update available!${RESET}"
        # create the fallback
        git checkout -b fallbacks
        git add .
        git add -u
        git commit -m "${DATE}"
        echo "${BLUE}[.] ${GREEN}Commit in fallbacks branch created at ${BLUE}${DATE}${RESET}"

        git checkout master
        git merge FETCH_HEAD
        echo "${RED}[!] ${GREEN}Running chain updater script.${RESET}"
        /bin/bash ${XPATH}/updater.sh --service-name ${SERVICE_NAME}
        echo "${BLUE}[.] ${GREEN}Done updating.${RESET}"
else
        echo "${RED}[.] ${GREEN}No updates.${RESET}"
fi