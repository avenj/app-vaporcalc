package App::vaporcalc::Role::UI::Cmd;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];


use Moo::Role;

has verb => (
  is       => 'ro',
  isa      => Str,
  builder  => sub { '' },
);

has params => (
  is       => 'ro',
  isa      => ArrayObj,
  coerce   => 1,
  builder  => sub { array },
);

has recipe => (
  required  => 1,
  is        => 'ro',
  isa       => RecipeObject,
  coerce    => 1,
  predicate => 'has_recipe',
  writer    => '_set_recipe',
);

requires 'execute';

1;
