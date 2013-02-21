#!/usr/bin/env perl

use JSON;
use PDF::FDF::Simple;
use Text::Iconv;

use strict;

my $PDFTK="pdftk";

my $PDF     = $ARGV[0];
my $PDF_OUT = $ARGV[1];

my $inp = join '', <STDIN>;
my $map = decode_json $inp;

my $cont = `$PDFTK $PDF generate_fdf output `;
my $fdf_in = (new PDF::FDF::Simple)->load($cont);

my @missing = grep { !exists $map->{$_} } sort keys %$fdf_in;

if (@missing){
    print STDERR "$PDF generating error\n";
    print STDERR "Fields missing: @missing\n";
    exit 1
}

my $c = Text::Iconv->new("utf-8", "utf-16");
my %converted = map { ($_, $c->convert($map->{$_})) } keys %$map;

my $fdf_out = new PDF::FDF::Simple;
$fdf_out->content({%converted});

my $fdf_out_str = $fdf_out->as_string;
print $fdf_out_str;
