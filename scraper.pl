#!/usr/bin/perl -w

use URI;
use Web::Scraper;
use Data::Dumper;
use XML::Twig;
use Text::CSV_XS qw( csv );

# Scrape nasdaq and extract dirty data from interesting table
my $rows = scraper {
  process 'table[id="indexTable"] script', 'script' => 'HTML';
};

my $dirty = $rows->scrape( URI->new("http://www.nasdaq.com") )->{script};

# Clean the dirty raw data
($dirty) = $dirty =~ m/CDATA\[(.*)\/\/\]/xms;
$dirty =~ s/nasdaqHomeIndexChart\.storeIndexInfo\(//g;
$dirty =~ s/&amp;/&/g;
$dirty =~ s/&quot;/"/g;
$dirty =~ s/\n//g;
$dirty =~ s/\);/;/g;
$dirty =~ s/\s//g;
$dirty =~ s/"//g;

# Create a usable data structure by first getting all the lines,
# then convert the lines
my @rows = split(';', $dirty);

print "\n\nNew data:\n".Dumper(\@rows)."\n\n";

my @nasdaqData = ();
map {
  # Only interested in the columns index, value and change.
  # The other data I strip away for now.
  my ($index, $value, $change, @unused) = split(',', $_);
  my @strippedRow = ($index, $value, $change);
  push @nasdaqData, \@strippedRow; 
} @rows;

if ( !-e 'nasdaq.csv') {
  # If the file does not already exist we just write to a new CSV
  csv(in => \@nasdaqData, out => 'nasdaq.csv');  
}
else {
  # Otherwise we have to compare the data,
  # just loop and if anything differs, write file.
  # read the file
  my @storedFile = @{csv(in => 'nasdaq.csv', sep_char => ',')};
  
  if (@nasdaqData ~~ @storedFile) {
    print $nasdaqData[0][1].' vs '.$storedFile[0][1]."\n";
    print "THEY MATCH\n";
  }
  else {
    print "THEY DIFFER, updating file\n";
    csv(in => \@nasdaqData, out => 'nasdaq.csv');  
  }
}

__END__
