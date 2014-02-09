use Test::More;
use strict; use warnings FATAL => 'all';

use File::Temp ();

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

## TO_JSON
my $hash = $recipe->TO_JSON;
is_deeply 
  $hash,
  +{
    target_quantity   => 30,
    base_nic_per_ml   => 36,
    base_nic_type     => 'PG',
    target_nic_per_ml => 12,
    target_pg         => 65,
    target_vg         => 35,
    flavor_percentage => 20,
    flavor_type       => 'PG',
    notes             => [],
  },
  'TO_JSON ok';

## Role::Store
subtest 'storage' => sub {
  if ($^O eq 'MSWin32') {
    plan skip_all => 'Temp files fail on some Windows platforms';
  }
  # save
  my $fh = File::Temp->new( UNLINK => 1 );
  my $fname = $fh->filename;
  ok $recipe->save($fname), 'save ok';
  # load
  my $loaded = App::vaporcalc::Recipe->load($fname);
  isa_ok $loaded, 'App::vaporcalc::Recipe';
  for my $key (keys %defaults) {
    ok $loaded->$key eq $defaults{$key}, "$key loaded ok"
  }
};

## Role::Calc
# calc
my $result = $recipe->calc;
ok $result->total  == 30, '30ml total';
ok $result->flavor == 6,  '6ml flavor';
ok $result->pg  == 3.5,   '3.5ml pg';
ok $result->vg  == 10.5,  '10.5ml vg';
ok $result->nic == 10,    '10ml nic';

## exceptions
# PG + VG != 100%
my %badratio = %defaults;
$badratio{target_pg} = 30; $badratio{target_vg} = 40;
eval {; App::vaporcalc::Recipe->new(%badratio) };
like $@, qr/target_vg/, 'bad PG-VG ratio dies';


done_testing
