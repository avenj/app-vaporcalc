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

=pod

=for Pod::Coverage TO_JSON

=head1 NAME

App::vaporcalc::Result - A calculated App::vaporcalc::Recipe result

=head1 SYNOPSIS

  use App::vaporcalc::Recipe;
  my $result = App::vaporcalc::Recipe->new(
    # See App::vaporcalc::Recipe
  );

  my $vg_ml     = $result->vg;
  my $pg_ml     = $result->pg;
  my $nic_ml    = $result->nic;
  my $flavor_ml = $result->flavor;
  my $total_ml  = $result->total;

=head1 DESCRIPTION

A calculated result produced by L<App::vaporcalc::Recipe>.

All quantities are in C<ml>.

=head2 ATTRIBUTES

=head3 vg

The required amount of VG filler.

=head3 pg

The required amount of PG filler.

=head3 nic

The required amount of nicotine base solution.

=head3 flavor

The required amount of flavor extract.

=head2 METHODS

=head3 total

The calculated total.

=head2 CONSUMES

L<App::vaporcalc::Role::Store>

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
