package App::vaporcalc::Role::Calc;

use Defaults::Modern;

use App::vaporcalc::Result;

use Role::Tiny;

requires qw/
  target_quantity
  base_nic_per_ml
  base_nic_type
  target_nic_per_ml
  target_pg
  target_vg
  flavor_percentage
  flavor_type
/;

method _normalized_base { 100 / ($self->base_nic_per_ml || return 1) }

method calc_base_nic_qty {
  my $rate = ($self->target_nic_per_ml || return 0) / 100;
  my $base_amt_ml = $self->target_quantity * $rate; 
  $base_amt_ml * $self->_normalized_base
}

method calc {
  my ($vg_ml, $pg_ml, $flavor_ml) = (0)x3;

  if ($self->target_vg) {
    $vg_ml = $self->target_quantity * ($self->target_vg / 100);
  }

  if ($self->target_pg) {
    $pg_ml = $self->target_quantity * ($self->target_pg / 100);
  }

  if ($self->flavor_percentage) {
    $flavor_ml = $self->target_quantity * ($self->flavor_percentage / 100);
  }

  my $nic_base_ml = $self->calc_base_nic_qty;

  # Subtract our nic base total from the appropriate PG or VG total:
  sswitch ($self->base_nic_type) {
    case 'PG': { $pg_ml = $pg_ml - $nic_base_ml }
    case 'VG': { $vg_ml = $vg_ml - $nic_base_ml }
    default: { confess "Unknown base_nic_type", $self->base_nic_type }
  }

  # Same for flavor:
  sswitch ($self->flavor_type) {
    case 'PG': { $pg_ml = $pg_ml - $flavor_ml }
    case 'VG': { $vg_ml = $vg_ml - $flavor_ml }
    default: { confess "Unknown flavor_type ", $self->flavor_type }
  }

  App::vaporcalc::Result->new(
    vg  => $vg_ml,
    pg  => $pg_ml,
    nic => $nic_base_ml,
    flavor => $flavor_ml,
    total  => $self->target_quantity,
  )
}

1;

