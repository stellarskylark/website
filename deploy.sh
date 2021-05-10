#!/bin/sh

cd pages
for f in *.md; do
  smu < "$f" > "$(basename "$f" .md).html"
done
cd ..
# For testing
find pages -type f -name '*.cfg' -print0 | sort -zr | xargs -0 saait
cp style.css ./output
# For deploying changes to production
#rm -r /var/www/andrewkhill.com/public_html/*
#find pages -type f -name '*.cfg' -print0 | sort -zr | xargs -0 saait -o /var/www/andrewkhill.com/public_html/
#cp style.css /var/www/andrewkhill.com/public_html/
