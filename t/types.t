use Test::More;
use Test::TypeTiny;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Types -all;

# VaporLiquid
should_pass 'PG', VaporLiquid;
should_pass 'VG', VaporLiquid;
should_fail 'foo', VaporLiquid;
should_fail 1, VaporLiquid;

# Percentage
should_pass 100, Percentage;
should_pass 0, Percentage;
should_pass 50, Percentage;
should_fail 101, Percentage;
should_fail -1, Percentage;

# RoundedResult
should_pass 1,    RoundedResult;
should_pass 1.1,  RoundedResult;
should_fail 1.11, RoundedResult;
ok RoundedResult->coerce(1.11) == 1.1, 'RoundedResult coerced ok';

# RecipeObject
my $foo = [];
bless $foo, 'App::vaporcalc::Recipe';
should_pass $foo, RecipeObject;
should_fail [], RecipeObject;

# ResultObject
bless $foo, 'App::vaporcalc::Result';
should_pass $foo, ResultObject;
should_fail [], ResultObject;


done_testing
