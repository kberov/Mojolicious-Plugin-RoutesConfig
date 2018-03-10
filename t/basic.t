use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use FindBin;
use lib "$FindBin::Bin/blog/lib";

my $t;
my $buffer = '';
{
  open my $handle, '>', \$buffer;
  local *STDERR = $handle;
  $t = Test::Mojo->new('Blog');
}

like $buffer, qr/"routes" key must point to an ARRAY/,
  'right warning about ARRAY reference';

like $buffer, qr/No routes de.+missing.conf/,
  'right warning about missing definitions';

like $buffer, qr/"routes" key must point to an ARRAY.+AY.conf/,
  'right warning about ARRAY reference in file';
say $buffer;

$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);


done_testing();
