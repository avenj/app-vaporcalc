use Test::More;
use Test::TypeTiny;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Types -all;

# VaporLiquid
should_pass 'PG',  VaporLiquid;
should_pass 'VG',  VaporLiquid;
should_fail 'foo', VaporLiquid;
should_fail 1,     VaporLiquid;

# Percentage
should_pass 100, Percentage;
should_pass 0,   Percentage;
should_pass 50,  Percentage;
should_fail 101, Percentage;
should_fail -1,  Percentage;

# RoundedResult
should_pass 1,    RoundedResult;
should_pass 1.1,  RoundedResult;
should_fail 1.11, RoundedResult;
ok RoundedResult->coerce(1.11) == 1.1, 'RoundedResult coerced ok';

my $foo = [];

# AppException
bless $foo, 'App::vaporcalc::Exception';
should_pass $foo, AppException;
should_fail [],   AppException;

# RecipeObject
bless $foo, 'App::vaporcalc::Recipe';
should_pass $foo, RecipeObject;
should_fail [],   RecipeObject;
my %settings = (
  target_quantity   => 10, base_nic_per_ml => 100,
  target_nic_per_ml => 12, target_pg => 65, target_vg => 35,
  flavor_percentage => 20
);
my $recipe = RecipeObject->coerce(\%settings);
ok $recipe->target_quantity == 10, 'RecipeObject coerced ok';
ok $recipe->flavor_percentage == 20;

# ResultObject
bless $foo, 'App::vaporcalc::Result';
should_pass $foo, ResultObject;
should_fail [],   ResultObject;
%settings = (
  pg => 2, vg => 2, flavor => 2, nic => 2
);
my $result = ResultObject->coerce(\%settings);
ok $result->pg == 2, 'ResultObject coerced ok';
ok $result->vg == 2;
ok $result->flavor == 2;

# RecipeResultSet
bless $foo, 'App::vaporcalc::RecipeResultSet';
should_pass $foo, RecipeResultSet;
should_fail [],   RecipeResultSet;

done_testing
