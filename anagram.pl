#!/usr/bin/env perl
use Data::Dumper;
my @words = @ARGV;

# basically, convert the words to arrays, sort them and compare
# then use the mighty hash to map them

my %indexedWords = ();
for my $word (@words) {
  my $sorted = join('', sort(split('', $word)));
  push @{$indexedWords{$sorted}}, $word;
}

# report the findings
print "Report\n";
for my $key (keys %indexedWords) {
  my $anagrams = $indexedWords{$key};
  
  if (@{$anagrams} > 1) {
    print @{$anagrams}.' anagrams: '.join(', ', @{$anagrams})."\n";
  }
  else {
    print "No anagrams: $anagrams->[0]\n";
  }
}