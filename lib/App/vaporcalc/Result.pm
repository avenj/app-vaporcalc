package App::vaporcalc::Result;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;

 
has vg => (
  required => 1,
  is       => 'ro',
  isa      => StrictNum,
);

has pg => (
  required => 1,
  is       => 'ro',
  isa      => StrictNum,
);

has nic => (
  required => 1,
  is       => 'ro',
  isa      => StrictNum,
);

has flavor => (
  required => 1,
  is       => 'ro',
  isa      => StrictNum,
);

has total => (
  required => 1,
  is       => 'ro',
  isa      => StrictNum,
);

method TO_JSON {
  +{
    map {; $_ => $self->$_ } qw/
      vg
      pg
      nic
      flavor
      total
    /,
  }
}

with 'App::vaporcalc::Role::Store';

1;
