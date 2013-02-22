#!/bin/sh

FDF_FILL=./fdf-fill.pl

$FDF_FILL "$1" | pdftk "$1" fill_form - output "$2"
