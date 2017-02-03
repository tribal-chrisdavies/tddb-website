git config --global user.email "Technical@ddb.com.au"
git config --global user.name "CircleCI AutoBuilder"

ruby data_importer.rb
git add .

CURDATE=$(TZ=":Australia/Sydney" date +'%r (%d-%m-%Y, %Z)')
git commit -m "Automated CircleCI rebuild at $CURDATE."

git push -f origin master
