use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use FindBin;
use lib "$FindBin::Bin/blog/lib";
my $t = Test::Mojo->new('Blog');
$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);

done_testing();
