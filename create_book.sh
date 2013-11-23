#!/bin/bash
FILES="preface.md
./*/*.md
"
for f in $FILES
do
  #["$f" =~ README.md ] && continue
  file=$(basename $f)
  [[ $file =~ README.md$ ]] && continue
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  # echo $f
  cat "$f" >> book.md
done
