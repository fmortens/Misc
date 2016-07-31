use Mojolicious::Lite;
use Text::CSV_XS qw( csv );
use Data::Dumper;
#use JSON;

my $storedFile = csv(in => 'nasdaq.csv', sep_char => ',');

get '/nasdaq/json' => {json => $storedFile};

get '/nasdaq'      => sub {
  my $self = shift;
  
  print Dumper($storedFile);
  
  $self->stash(
    storedFile => $storedFile
  );
  
} => 'nasdaq';

app->start;

__DATA__
@@ nasdaq.html.ep

<!DOCTYPE html>
<html>
  <body>
    <table>
      <tr>
        <th>Index</th>
        <th>Value</th>
        <th>Change</th>  
      </tr>
    % for my $i (@{$storedFile}) {
      <tr>
        <td><%=$i->[0]%></td>
        <td><%=$i->[1]%></td>
        <td><%=$i->[2]%></td>
      </tr>
    %}
  </body>
</html>
