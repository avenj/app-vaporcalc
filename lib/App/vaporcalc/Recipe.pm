package App::vaporcalc::Recipe;

use Defaults::Modern
  -with_types => [
    'App::vaporcalc::Types',
  ];

use Moo; use MooX::late;

has target_quantity   => (
  required => 1,
  is       => 'ro',
  isa      => Int,
);

has base_nic_per_ml   => (
  required => 1,
  is       => 'ro',
  isa      => Int,
);

has base_nic_type     => (
  is      => 'ro',
  isa     => VaporLiquid,
  coerce  => 1,
  builder => sub { 'PG' },
);

has target_nic_per_ml => (
  required => 1,
  is       => 'ro',
  isa      => Int,
);

has target_pg         => (
  required => 1,
  is       => 'ro',
  isa      => Percentage,
);

has target_vg         => (
  required => 1,
  is       => 'ro',
  isa      => Percentage,
);

has flavor_percentage => (
  required => 1,
  is       => 'ro',
  isa      => Percentage,
);

has flavor_type       => (
  is      => 'ro',
  isa     => VaporLiquid,
  coerce  => 1,
  builder => sub { 'PG' },
);

has notes             => (
  lazy    => 1,
  is      => 'ro',
  isa     => TypedArray[Str],
  coerce  => 1,
  builder => sub { array_of Str },
);

method BUILD {
  unless ($self->target_vg + $self->target_pg == 100) {
    confess "Expected target_vg + target_pg == 100\n",
      "  target_vg ", $self->target_vg, "\n",
      "  target_pg ", $self->target_pg
  }
}

method TO_JSON {
  +{
    map {; $_ => $self->$_ } qw/
      target_quantity
      base_nic_per_ml
      base_nic_type
      target_nic_per_ml
      target_pg
      target_vg
      flavor_percentage
      flavor_type
      notes
    /
  }
}

with 'App::vaporcalc::Role::Calc';

1;
