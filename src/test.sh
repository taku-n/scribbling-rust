#!/bin/bash

for x in $(find -name "*.md"); do
	mainname=$(echo $x | sed 's/\.[^\.]*$//')
	out=${mainname}.rs
	sed "s/^/\/\/\/ /g" $x > $out
	echo "#[allow(dead_code)]" >> $out
	echo "fn f() {}" >> $out
done

cargo test
