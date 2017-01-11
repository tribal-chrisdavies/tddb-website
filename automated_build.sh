git config --global user.email "chris.lim-davies@au.tribalworldwide.com"
git config --global user.name "Chris Davies (CircleCI)"

git checkout gh-pages 2>/dev/null || git checkout -b gh-pages
git merge master

bundle exec jekyll contentful --rebuild --trace
git add .

CURDATE=$(TZ=":Australia/Sydney" date +'%r (%d-%m-%Y, %Z)')
git commit -m "Automated rebuild at $CURDATE."

git push -f origin gh-pages
