#!/opt/local/bin/perl

use strict;
use LWP::Simple;

my @anime_list = (8499,8148,8242,8288,8101,7729,7224,7934,8057,7883,6645,7103,7208,6529,8421,7439,8177,8211);

my @data = ();

for (@anime_list){
  $_ = get("http://anidb.net/perl-bin/animedb.pl?show=anime&aid=$_") || die "Could not get site: $!\n";
  my $anime	= $1 if m#anime\"\>(.*)\</h1\>#o;
  my $rating	= $1 if /\>(\d+\.\d+)\</o;

  push @data, { anime	=> $anime,
	        rating	=> $rating,
	      };
}

print join "\n", map {$_->{anime}." - ".$_->{rating}} sort {$b->{rating} <=> $a->{rating}} @data;
print "\n";

