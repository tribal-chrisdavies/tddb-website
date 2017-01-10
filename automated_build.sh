bundle exec jekyll contentful --build

git config --global user.email "chris.lim-davies@au.tribalworldwide.com"
git config --global user.name "Chris Davies (CircleCI)"

git checkout gh-pages
git add .

CURDATE="$(date +'%T (%d/%m/%Y)')"
git commit -m "Automated rebuild at $CURDATE."

git push -f origin gh-pages
