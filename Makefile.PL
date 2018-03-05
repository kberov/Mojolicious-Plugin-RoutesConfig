use 5.020000;
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
my $preop = qq'pod2text lib/Mojolicious/Command/generate/resources.pm > README;'
  . qq'pod2markdown lib/Mojolicious/Command/generate/resources.pm > README.md';
WriteMakefile(
  NAME         => 'Mojolicious::Plugin::RoutesConfig',
  VERSION_FROM => 'lib/Mojolicious/Plugin/RoutesConfig.pm',    # finds \$VERSION
  AUTHOR       => 'Красимир Беров (berov@cpan.org)',
  ABSTRACT     => 'Describe routes in configuration',
  PREREQ_PM => {'Mojolicious' => '7.70', perl => '5.020000'},
  test       => {TESTS => 't/*.t'},
  clean      => {FILES => 'Mojolicious-Plugin-*'},
  dist       => {PREOP => $preop},
  META_MERGE => {
     dynamic_config => 0,
     'meta-spec'    => {version => 2},
     no_index       => {directory => ['t']},
     prereqs        => {runtime => {requires => {perl => '5.020000'}}},
     resources      => {
       bugtracker => {
            web =>
              'https://github.com/kberov/Mojolicious-Plugin-RoutesConfig/issues'
       },
       homepage => 'https://github.com/kberov/Mojolicious-Plugin-RoutesConfig',
       license  => ['http://www.opensource.org/licenses/artistic-license-2.0'],
       repository => {
         type => 'git',
         url => 'https://github.com/kberov/Mojolicious-Plugin-RoutesConfig.git',
         web => 'https://github.com/kberov/Mojolicious-Plugin-RoutesConfig',
       },
     },
  },
);

