bundle exec jekyll contentful
bundle exec jekyll build

git config --global user.email "chris.lim-davies@au.tribalworldwide.com"
git config --global user.name "Chris Davies"

git add .
git commit -m "Automated Rebuild"
git push -f origin master
