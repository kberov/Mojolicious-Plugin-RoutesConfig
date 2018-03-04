

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Mojolicious::Plugin::RoutesConfig',
    VERSION_FROM => 'lib/Mojolicious/Plugin/RoutesConfig.pm', # finds \$VERSION
    AUTHOR       => 'Красимир Беров (berov@cpan.org)',
    ABSTRACT     => 'Describe routes in configuration',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                    },
);
