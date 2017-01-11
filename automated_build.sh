git config --global user.email "chris.lim-davies@au.tribalworldwide.com"
git config --global user.name "Chris Davies (CircleCI)"

bundle exec jekyll contentful --rebuild --trace
git add .

CURDATE=$(TZ=":Australia/Sydney" date +'%r (%d-%m-%Y, %Z)')
git commit -m "Automated rebuild at $CURDATE."

git push -f origin master
