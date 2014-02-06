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
  +{ recipe => $self->recipe, result => $self->result }
}

with 'App::vaporcalc::Role::Store';

1;
