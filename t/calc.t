use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc 'vcalc';

my $ret = vcalc(
  target_quantity   => 10,
  base_nic_per_ml   => 100,
  target_nic_per_ml => 16,
  target_pg         => 65,
  target_vg         => 35,
  flavor_percentage => 20,
);

my $result = $ret->result;

cmp_ok $result->total, '==', 10, '10ml total';
cmp_ok $result->flavor, '==', 2, '2ml flavor';
cmp_ok $result->pg, '==', 2.9, '2.9ml PG';
cmp_ok $result->vg, '==', 3.5, '3.5ml VG';
cmp_ok $result->nic, '==', 1.6, '1.6ml nic';

# FIXME test different bases
#  check against online calcs


done_testing
