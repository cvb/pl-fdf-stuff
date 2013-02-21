#!/usr/bin/env perl

use JSON;
use PDF::FDF::Simple;

use Data::Dumper;

$PDFTK="pdftk";

$PDF = $ARGV[0];
$PDF_ARGS = "$PDF generate_fdf output -";
my $cont = `$PDFTK $PDF_ARGS`;
$fdf = new PDF::FDF::Simple;

my $fdfcontent = $fdf->load($cont);

print encode_json $fdfcontent;
