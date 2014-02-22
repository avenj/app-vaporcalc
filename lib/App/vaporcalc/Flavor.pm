package App::vaporcalc::Flavor;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;
use overload
  '""' => sub { shift->tag },
  '0+' => sub { shift->percentage },
  bool => sub { 1 },
  fallback => 1;

has percentage => (
  required  => 1,
  is        => 'ro',
  isa       => Percentage,
);

has tag => (
  required  => 1,
  is        => 'ro',
  isa       => Str,
);

has type => (
  is        => 'ro',
  isa       => VaporLiquid,
  coerce    => 1,
  builder   => sub { 'PG' },
);

method TO_JSON {
  +{
    percentage => $self->percentage,
    tag        => $self->tag,
    type       => $self->type,
  }
}

with 'App::vaporcalc::Role::Store';

1;
