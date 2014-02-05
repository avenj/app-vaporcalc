use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Recipe;

my %defaults = (
  target_quantity   => 30,
  base_nic_per_ml   => 36,
  target_nic_per_ml => 12,
  target_pg         => 65,
  target_vg         => 35,
  flavor_percentage => 20,
);

my $recipe = App::vaporcalc::Recipe->new(%defaults);

ok $recipe->flavor_type eq 'PG', 'flavor_type default ok';
ok $recipe->notes->count == 0,   'notes default ok';

## Role::Calc
# calc
my $result = $recipe->calc;
ok $result->total  == 30, '30ml total';
ok $result->flavor == 6,  '6ml flavor';
ok $result->pg  == 3.5,   '3.5ml pg';
ok $result->vg  == 10.5,  '10.5ml vg';
ok $result->nic == 10,    '10ml nic';


## Role::Store
# save
#FIXME save to a File::Temp
# load
#FIXME

## exceptions
# PG + VG != 100%
my %badratio = %defaults;
$badratio{pg} = 30; $badratio{vg} = 40;
eval {; App::vaporcalc::Recipe->new(%badratio) };
like $@, qr/target_vg/, 'bad PG-VG ratio dies';

#FIXME
# missing required attribs

done_testing
