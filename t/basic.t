
use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Mojo::Util 'decode';
use FindBin;
use lib "$FindBin::Bin/blog/lib";

my $buffer = '';
{
$ENV{MOJO_HOME} = "$FindBin::Bin/blog";
  open my $handle, '>', \$buffer;
  local *STDERR = $handle;
  require Blog;
  my $blog = Blog->new;
  $blog->startup();
}
like $buffer, qr/"routes" key must point to an ARRAY/,
  'right warning about ARRAY reference';

like $buffer, qr/No routes de.+missing.conf/,
  'right warning about missing definitions';

like $buffer, qr/"routes" key must point to an ARRAY.+AY\.conf/,
  'right warning about ARRAY reference in file';

like $buffer, qr/.+complex.+\.conf.+route initialisation method/ms,
  'right warning about missing route initialisation method';

like $buffer, qr/.+complex.+\.conf.+method "blah" via package/ms,
  'right warning about unknown method';
my $t;
$t = Test::Mojo->new('Blog');
$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);


done_testing();
