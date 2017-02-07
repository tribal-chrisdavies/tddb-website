# Set up git
git config --global user.email "Technical@ddb.com.au"
git config --global user.name "CircleCI AutoBuilder"

# Change to MASTER branch with a clean copy
git checkout -f
git checkout master
git fetch origin master
git reset --hard origin/master

# Update data
ruby data_importer.rb

# Get _site/* files and push them to MASTER branch
# Note: CircleCI creates vendor and .bundle files
mv _site /tmp/
rm -rf * .bundle .sass-cache
mv /tmp/_site/* .

# Commit changes
git add -A .
CURDATE=$(TZ=":Australia/Sydney" date +'%r (%d-%m-%Y, %Z)')
git commit -m "Automated CircleCI rebuild at $CURDATE."
git push -f origin master
