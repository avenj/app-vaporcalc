package App::vaporcalc::Result;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;

 
has vg => (
  required => 1,
  is       => 'ro',
  isa      => RoundedResult,
  coerce   => 1,
);

has pg => (
  required => 1,
  is       => 'ro',
  isa      => RoundedResult,
  coerce   => 1,
);

has nic => (
  required => 1,
  is       => 'ro',
  isa      => RoundedResult,
  coerce   => 1,
);

has flavor => (
  required => 1,
  is       => 'ro',
  isa      => RoundedResult,
  coerce   => 1,
);

method total {
  $self->vg + $self->pg + $self->nic + $self->flavor
}

method TO_JSON {
  +{
    map {; $_ => $self->$_ } qw/
      vg
      pg
      nic
      flavor
    /,
  }
}

with 'App::vaporcalc::Role::Store';

1;
