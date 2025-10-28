#!/bin/bash

FILE_LIST=`git diff --name-only origin/main...HEAD`

PHP_LIST=`echo "$FILE_LIST" | egrep ".php$"`
JS_LIST=`echo "$FILE_LIST" | grep ".js$"`
CSS_LIST=`echo "$FILE_LIST" | grep ".css$"`

BASE_PHP_LIST=`echo "$PHP_LIST" | awk -F"/" '{print $NF}' `

PHP_FILES_AFFECTED_BY_JS_OR_CSS=`node bin/find-affected-pages.js \
  --dir ./tmp/vnu/ \
  --exts ".php" \
  --quiet --just-pages --results-relative \
  --match basename \
  --files "$(git diff --name-only origin/main...HEAD | paste -sd, -)" `


LIST="$BASE_PHP_LIST
$PHP_FILES_AFFECTED_BY_JS_OR_CSS"

echo "$LIST" | sort -u