package App::vaporcalc::Result;

use Defaults::Modern;

use Moo; use MooX::late;

has vg => (
  required => 1,
  is       => 'ro',
  isa      => Num,
);

has pg => (
  required => 1,
  is       => 'ro',
  isa      => Num,
);

has nic => (
  required => 1,
  is       => 'ro',
  isa      => Num,
);

has flavor => (
  required => 1,
  is       => 'ro',
  isa      => Num,
);

has total => (
  required => 1,
  is       => 'ro',
  isa      => Num,
);


method BUILD {
  my $real_total = $self->vg + $self->pg + $self->nic + $self->flavor;
  unless ($real_total == $self->total) {
    carp "Totals do not add up!",
      "  VG: ", $self->vg, "\n",
      "  PG: ", $self->pg, "\n",
      "  NIC: ", $self->nic, "\n",
      "  FLAV: ", $self->flavor, "\n",
      "    == $real_total\n", 
      "  Wanted ", $self->total
  }
}

1;
