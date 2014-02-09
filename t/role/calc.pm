use Test::More;
use strict; use warnings FATAL => 'all';

{ package
    MyCalc;
  use Moo; 
  sub target_quantity { 10 }
  sub base_nic_per_ml { 100 }
  sub base_nic_type   { 'PG' }
  sub target_nic_per_ml { 16 }
  sub target_pg { 65 }
  sub target_vg { 35 }
  sub flavor_percentage { 20 }
  sub flavor_type { 'PG' }
  with 'App::vaporcalc::Role::Calc';
}

my $result =  MyCalc->new->calc;
isa_ok $result, 'App::vaporcalc::Result';
ok $result->flavor == 2, '2ml flavor';
ok $result->pg     == 2.9, '2.9ml PG';
ok $result->vg     == 3.5, '3.5ml VG';
ok $result->nic    == 1.6, '1.6ml nic';
ok $result->total  == 10, '10ml total';

done_testing
