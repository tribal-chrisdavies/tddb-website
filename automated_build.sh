# Copy static site
CWD=`pwd`

# Clone Pages repository
cd /tmp
git clone https://github.com/tribal-chrisdavies/tribal-chrisdavies.github.io.git build
# cd build && git checkout -b master origin/master # If not using master

# Trigger Jekyll rebuild
cd $CWD
bundle exec jekyll contentful
bundle exec jekyll build

# Push newly built repository
cp -r $CWD/_build/* /tmp/build # or $CWD/_site

cd /tmp/build

git config --global user.email "chris.lim-davies@au.tribalworldwide.com"
git config --global user.name "Chris Davies"

git add .
git commit -m "Automated Rebuild"
git push -f origin master
