#!/bin/bash
cd $1
for file in *
do
	if [[ $file =~ \.zip$ ]]; then
		continue
	fi

	zip -r $file.zip $file
done
