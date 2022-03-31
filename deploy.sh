#!/bin/sh

rm -r ./output/*

# Build pieces pages and categories of the index
cd pieces
for f in $(find pages -type f -name '*.md'); do
  smu < "$f" > "${f%.md}.html"
done
for cat in pages/*; do
  saait $cat/*.cfg
  mv output/tmp.html "../pages/$(basename "$cat").html"
done
cp output/* ../output
cd ..

# Build blog index and pages
cd blog
for f in $(find pages -type f -name '*.md'); do
  smu < "$f" > "${f%.md}.html"
done
find pages -type f -name '*.cfg' -print0 | sort -zr | xargs -0 saait -o ../output/
cd ..

# Build final site markdown 
for f in $(find templates -type f -name '*.md'); do
  smu < "$f" > "${f%.md}.html"
  cat "${f%\/*}/header_base.html" "${f%.md}.html" > "${f%\/*}/header.html"
done

# Build final site
find pages -type f -name '*.cfg' -print0 | sort -zr | xargs -0 saait
cp style.css ./output
cp -r assets ./output/assets

# For deploying changes to production
rm -r /var/www/andrewkhill.com/public_html/*
cp -r ./output/* /var/www/andrewkhill.com/public_html/
cp ../public-files/* /var/www/andrewkhill.com/public_html/
