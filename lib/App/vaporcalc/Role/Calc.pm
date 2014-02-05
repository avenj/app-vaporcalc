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

method _base_multiplier { 100 / ($self->base_nic_per_ml || return 1) }

method _calc_base_nic_qty {
  return 0 unless $self->target_nic_per_ml;
  my $rate = $self->target_nic_per_ml / 100;
  my $base_amt_ml = $self->target_quantity * $rate; 
  $base_amt_ml * $self->_base_multiplier
}

method _calc_total_vg_qty {
  return 0 unless $self->target_vg;
  $self->target_quantity * ($self->target_vg / 100)
}

method _calc_total_pg_qty {
  return 0 unless $self->target_pg;
  $self->target_quantity * ($self->target_pg / 100)
}

method _calc_total_flavor_qty {
  return 0 unless $self->flavor_percentage;
  $self->target_quantity * ($self->flavor_percentage / 100)
}

method calc {
  my $vg_ml     = $self->_calc_total_vg_qty;
  my $pg_ml     = $self->_calc_total_pg_qty;
  my $flavor_ml = $self->_calc_total_flavor_qty;
  my $nic_base_ml = $self->_calc_base_nic_qty;

  # Subtract our nic base total from the appropriate PG or VG total:
  sswitch ($self->base_nic_type) {
    case 'PG': { $pg_ml -= $nic_base_ml if $pg_ml }
    case 'VG': { $vg_ml -= $nic_base_ml if $vg_ml }
    default: { confess "Unknown base_nic_type", $self->base_nic_type }
  }

  # Same for flavor:
  sswitch ($self->flavor_type) {
    case 'PG': { $pg_ml -= $flavor_ml if $pg_ml }
    case 'VG': { $vg_ml -= $flavor_ml if $vg_ml }
    default: { confess "Unknown flavor_type ", $self->flavor_type }
  }

  App::vaporcalc::Result->new(
    vg  => sprintf('%.1f', $vg_ml),
    pg  => sprintf('%.1f', $pg_ml),
    nic => sprintf('%.1f', $nic_base_ml),
    flavor => sprintf('%.1f', $flavor_ml),
    total  => $self->target_quantity,
  )
}

1;

