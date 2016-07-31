#!/usr/bin/env perl
use strict;

print "Tic tac toe\n";

my @raw = split('', @ARGV[0]);

# Rules, to make things easier
my $rules = {
  'vertical'   => [[0,3,6],[1,4,7],[2,5,8]],
  'horizontal' => [[0,1,2],[3,4,5],[6,7,8]],
  'diagonal'   => [[0,4,8],[2,4,6]]
};

# Dirty comparizon, basically run the matching function for vertical,
# horizontal and vertical directions for both suits, x and y
my $tests = {
  x => ['vertical', 'horizontal', 'diagonal'],
  y => ['vertical', 'horizontal', 'diagonal'],
};

foreach my $suit (keys %$tests) {
  my $tests = $tests->{$suit};
  foreach my $test (@{$tests}) {
    if (matching($test, $suit)) {
      print "Winner is $suit, ($test)\n";
      exit 0;
    }
  }
}

sub matching {
  my ($direction, $color) = @_;

  foreach my $series ( @{ $rules->{$direction} } ) {

    my @matches = grep {$_ eq $color} (
      $raw[ $series->[0] ],
      $raw[ $series->[1] ],
      $raw[ $series->[2] ] # only used for horizontal and vertical
    );

    if (scalar @matches eq 3) {
      return $color;
    }
  }
}

__END__
