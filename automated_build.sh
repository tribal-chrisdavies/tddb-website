export CONT_ACCESS_TOKEN=${CONT_ACCESS_TOKEN}
export CONT_SPACE_ID=${CONT_SPACE_ID}

git config --global user.email "chris.lim-davies@au.tribalworldwide.com"
git config --global user.name "Chris Davies (CircleCI)"

bundle exec jekyll contentful --rebuild --trace
git add .

CURDATE=$(TZ=":Australia/Sydney" date +'%r (%d-%m-%Y, %Z)')
git commit -m "Automated CircleCI rebuild at $CURDATE."

git push -f origin master
