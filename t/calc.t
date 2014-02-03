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

# Intentionally 'eq':
cmp_ok $result->total,  '==', 10, '10ml total';
cmp_ok $result->flavor, '==', 2,  '2ml flavor';
cmp_ok $result->pg,  'eq', '2.9', '2.9ml PG';
cmp_ok $result->vg,  'eq', '3.5', '3.5ml VG';
cmp_ok $result->nic, 'eq', '1.6', '1.6ml nic';

$ret = vcalc(
  target_quantity   => 30,
  base_nic_per_ml   => 36,
  target_nic_per_ml => 12,
  target_pg         => 65,
  target_vg         => 35,
  flavor_percentage => 20,
);

cmp_ok $result->total,  '==', 30,  '30ml total';
cmp_ok $result->flavor, '==', 6,   '6ml flavor';
cmp_ok $result->pg,  'eq', '3.5',  '19.5ml PG';
cmp_ok $result->vg,  'eq', '10.5', '10.5ml VG';
cmp_ok $result->nic, '==', 10,     '10ml nic';


done_testing
