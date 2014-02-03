package App::vaporcalc::Recipe;
use Defaults::Modern
  -with_types => [
    'App::vaporcalc::Types',
  ];

use Moo; use MooX::late;

has target_quantity   => (
  is      => 'ro',
  isa     => Int,
  builder => sub { 10 },
);

has base_nic_per_ml   => (
  is      => 'ro',
  isa     => Int,
  builder => sub { 100 },
);

has base_nic_type     => (
  is      => 'ro',
  isa     => VaporLiquid,
  coerce  => 1,
  builder => sub { 'PG' },
);

has target_nic_per_ml => (
  is      => 'ro',
  isa     => Int,
  builder => sub { 16 },
);

has target_pg         => (
  is      => 'ro',
  isa     => Int,
  builder => sub { 60 },
);

has target_vg         => (
  is      => 'ro',
  isa     => Int,
  builder => sub { 40 },
);

has flavor_percentage => (
  is      => 'ro',
  isa     => Int,
  builder => sub { 15 },
);

has flavor_type       => (
  is      => 'ro',
  isa     => VaporLiquid,
  coerce  => 1,
  builder => sub { 'PG' },
);

method BUILD {
  unless ($self->target_vg + $self->target_pg == 100) {
    confess "Expected target_vg + target_pg == 100\n",
      "  target_vg ", $self->target_vg, "\n",
      "  target_pg ", $self->target_pg
  }
}

with 'App::vaporcalc::Role::Calc';

1;
