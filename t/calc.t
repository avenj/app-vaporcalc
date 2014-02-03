use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc 'vcalc';

my $res = vcalc(
  quantity        => '10',    # 10ml target

  base_nicotine   => '100',   # 100mg/ml base
  target_nicotine => '16',    # 16mg/ml target

  target_pg       => '65',    # %
  target_vg       => '35',    # %

  flavor_amount   => '20',    # %
  flavor_is       => 'pg',    # PG/VG flavor base
);

done_testing
