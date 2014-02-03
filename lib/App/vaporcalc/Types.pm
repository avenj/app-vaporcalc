package App::vaporcalc::Types;

use strict; use warnings FATAL => 'all';

use Type::Library   -base;
use Types::Standard -types;
use Type::Utils     -all;

declare VaporLiquid =>
  as Str(),
  where { $_ eq 'PG' or $_ eq 'VG' };

coerce VaporLiquid =>
  from Str(),
  via { uc $_ };

1;
