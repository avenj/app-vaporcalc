use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Result;

my $obj = App::vaporcalc::Result->new(
  vg  => 2,
  pg  => 2,
  nic => 2,
  flavor => 2,
);

ok $obj->total == 8, 'total ok';

my $ref = $obj->TO_JSON;
is_deeply 
  $ref,
  +{ vg => 2, pg => 2, nic => 2, flavor => 2 },
  'TO_JSON ok';

ok $obj->does('App::vaporcalc::Role::Store'),
  'does Role::Store';

done_testing
