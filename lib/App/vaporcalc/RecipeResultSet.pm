package App::vaporcalc::RecipeResultSet;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];


use Moo; use MooX::late;

has recipe => (
  required => 1,
  is       => 'ro',
  isa      => RecipeObject,
  coerce   => 1,
);

has result => (
  init_arg => undef,
  lazy     => 1,
  is       => 'ro',
  isa      => ResultObject,
  coerce   => 1,
  writer   => '_set_result',
  builder  => sub { $_[0]->recipe->calc },
);

method TO_JSON {
  +{ recipe => $self->recipe }
}

with 'App::vaporcalc::Role::Store';

1;

=pod

=head1 NAME

App::vaporcalc::RecipeResultSet - An e-liquid recipe and result pair

=head1 SYNOPSIS

=head1 DESCRIPTION

=head2 ATTRIBUTES

=head2 CONSUMES

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
