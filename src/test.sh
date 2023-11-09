#!/bin/bash

for x in $(find -name "*.md"); do
	mainname=$(echo $x | sed 's/\.[^\.]*$//')
	out=${mainname}.rs
	sed "s/^/\/\/! /g" $x > $out
done

cargo test
