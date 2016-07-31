#!/usr/bin/env perl

use strict;
use Data::Dumper;

my $fileName      = $ARGV[0];
my $numComments   = 0;
my $numBlankLines = 0;
my $numCodeLines  = 0;

if (!$fileName) {
  print "Usage: codeInspector.pl <fileName>\n";
  exit 0;
}

if (! -e $fileName) {
  print "Could not find $fileName\n";
  exit 0;
}

print "Inspecting $fileName\n";

open(FILE, "<$fileName");
my (@lines) = <FILE>;

# Analyzing lines
for my $line (@lines) {

  if ($line =~ m/^\#+/) {
    $numComments++;
    next;
  }

  elsif ($line =~ m/^\s*\n+/) {
    $numBlankLines++;
    next;
  }
}

$numCodeLines = (scalar @lines) - $numComments - $numBlankLines;

print "Report\n";
print "Num comments: $numComments\n";
print "Num blank lines: $numBlankLines\n";
print "Num code lines: $numCodeLines\n";