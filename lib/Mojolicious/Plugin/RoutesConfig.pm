package Mojolicious::Plugin::RoutesConfig;
use Mojo::Base 'Mojolicious::Plugin::Config';
use List::Util qw(first);

sub register {
  my ($self, $app, $conf) = @_;
  my $file = $conf->{file};
  my $file_msg = ($file ? ' in file ' . $file : '');
  $conf = $self->load($file, {}, $app) if $file;
  $app->log->warn('No routes definitions found' . $file_msg . '...') && return
    unless exists $conf->{routes};

  $app->log->warn(  '"routes" key must point to an ARRAY reference '
                  . 'of routes descriptions'
                  . $file_msg . '...')
    && return
    unless ref $conf->{routes} eq 'ARRAY';

  $self->_generate_routes($app, $conf->{routes});
  return $self;
}

#generates routes recursively
sub _generate_routes {
  my ($self, $app, $routes_conf, $current) = @_;
  my $routes = $app->routes;
  for my $rconf (@$routes_conf) {
    my $init_method = first(
      sub {
        $_ =~ /^any|route|get|post|patch|put|delete|options$/;
      },
      keys %$rconf
                           );
    my $params = delete $rconf->{$init_method};
    my $route
      = $routes->$init_method(
                              ref $params eq 'ARRAY'
                              ? @$params
                              : (ref $params eq 'HASH' ? %$params : $params));
    for my $method (keys %$rconf) {
      while (my $params = delete $rconf->{$method}) {
        $route->method(
                       ref $params eq 'ARRAY'
                       ? @$params
                       : (ref $params eq 'HASH' ? %$params : $params));
      }
    }

  }
  return;
}

=encoding utf8

=head1 NAME

Mojolicious::Plugin::RoutesConfig - Describe routes in configuration

=head1 SYNOPSIS

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

L<Mojolicious::Plugin::RoutesConfig> allows you to define your routes in
configuration file or in a separate file, for example
C<$MOJO_HOME/etc/plugins/routes.conf>. This way you can quickly enable and
disable parts of your application without editing its source code.

The routes are described the same way as you would generate them
imperatively, just instead of methods you use method names as keys and
suitable references as values which will be dereferenced and passed as arguments to
the respective method. For allowed keys look at L<Mojolicious::Routes::Route>. 

=head1 METHODS

L<Mojolicious::Plugin::RoutesConfig> inherits all methods from L<Mojolicious::Plugin::Config> and implements the following new ones.

=head2 register

  my $config = $plugin->register(Mojolicious->new, $config);
  my $config = $plugin->register($app, {file => '/etc/app_routes.conf'});

Register the plugin in L<Mojolicious> application and generate routes. 

=head1 AUTHOR

    Красимир Беров
    CPAN ID: BEROV
    berov ат cpan точка org
    http://i-can.eu

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the terms of Artistic License 2.0.

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

L<Mojolicious>

=cut

#################### main pod documentation end ###################


1;

