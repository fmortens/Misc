Short explaination
==================

scraper.pl
----------
Scrapes nasdaq.com and extracts data. Data is stored to nasdaq.csv used by serve.pl
```bash
perl scraper.pl
```

serve.pl
--------
Provides web interface to nasdaq.csv.

```bash
perl serve.pl daemon
```

The working URIs are:
* /nasdaq _Shows the file_
* /nasdaq/json _Converts it to plain json_

codeinspector.pl
----------------
Inspects a code file and prints stats for that file

```bash
perl codeinspector.pl <filename/path>
```

tictactoe.pl
------------
Analyzes a tictactoe board and finds winners.
Format of board is plain string, read from top left to right.
Use the suits x and y:

```bash
perl tictactoe.pl 'xxxyy   y'
```

Dependencies
------------
* Mojolicious::Lite
* Text::CSV_XS
* URI
* Web::Scraper
* XML::Twig
* Mozilla::CA