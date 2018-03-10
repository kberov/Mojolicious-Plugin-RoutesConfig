package Blog;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  $self->plugin('RoutesConfig', $config);
  $self->plugin('RoutesConfig',
                {file => $self->home->child('etc/routes_not_ARRAY.conf')});
  $self->plugin('RoutesConfig',
                {file => $self->home->child('etc/routes_missing.conf')});

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
}

1;
