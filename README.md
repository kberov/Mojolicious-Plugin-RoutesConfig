# NAME

Mojolicious::Plugin::RoutesConfig - Describe routes in configuration

# SYNOPSIS

    # Create $MOJO_HOME/etc/routes.conf and describe your routes
    # or do it directly in $MOJO_HOME/${\ $app->moniker }.conf
    {
      routes => [
        {get  => '/groups', to => 'groups#list', name => 'list_groups'},
        {post => '/groups', to => 'groups#create'},
        {any => {[qw(GET POST)] => '/users'}, to => 'users#list_or_create'},
      ],
    }

    # Mojolicious
    my $config = $app->plugin('Config');

    $app->plugin('RoutesConfig', $config);
    $app->plugin('RoutesConfig', {file => $app->home->child('etc/routes_admin.conf')});
    $app->plugin('RoutesConfig', {file => $app->home->child('etc/routes_site.conf')});

    # Mojolicious::Lite
    my $config = plugin 'Config';
    plugin 'RoutesConfig', $config;
    plugin 'RoutesConfig', {file => app->home->child('etc/routes_admin.conf')};
    plugin 'RoutesConfig', {file => app->home->child('etc/routes_site.conf')};
  =head1 DESCRIPTION

[Mojolicious::Plugin::RoutesConfig](https://metacpan.org/pod/Mojolicious::Plugin::RoutesConfig) allows you to define your routes in
configuration file or in a separate file, for example
`$MOJO_HOME/etc/plugins/routes.conf`. This way you can quickly enable and
disable parts of your application without editing its source code.

The routes are described the same way as you would generate them
imperatively, just instead of methods you use method names as keys and
suitable references as values which will be dereferenced and passed as arguments to
the respective method. For allowed keys look at [Mojolicious::Routes::Route](https://metacpan.org/pod/Mojolicious::Routes::Route). 

# METHODS

[Mojolicious::Plugin::RoutesConfig](https://metacpan.org/pod/Mojolicious::Plugin::RoutesConfig) inherits all methods from [Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config) and implements the following new ones.

## register

    my $config = $plugin->register(Mojolicious->new, $config);
    my $config = $plugin->register($app, {file => '/etc/app_routes.conf'});

Register the plugin in [Mojolicious](https://metacpan.org/pod/Mojolicious) application and generate routes. 

# AUTHOR

    Красимир Беров
    CPAN ID: BEROV
    berov ат cpan точка org
    http://i-can.eu

# COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the terms of Artistic License 2.0.

The full text of the license can be found in the
LICENSE file included with this module.

# SEE ALSO

[Mojolicious](https://metacpan.org/pod/Mojolicious)