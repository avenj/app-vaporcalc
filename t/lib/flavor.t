use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Flavor;

my $flav = App::vaporcalc::Flavor->new(
  percentage => 10,
  tag        => 'TFA Raspberry',
);

ok $flav->percentage == 10, 'percentage ok';
ok $flav->tag eq 'TFA Raspberry', 'tag ok';
ok $flav->type eq 'PG', 'default type ok';

$flav = App::vaporcalc::Flavor->new(
  percentage => 10,
  tag        => 'TFA Marshmallow',
  type       => 'VG',
);

ok $flav->type eq 'VG', 'type ok';

eval {;
  App::vaporcalc::Flavor->new(percentage => 10)
};
ok $@, 'missing required attrib "tag" dies ok';

eval {;
  App::vaporcalc::Flavor->new(percentage => 101)
};
ok $@, 'invalid attrib "percentage" dies ok';

eval {;
  App::vaporcalc::Flavor->new(tag => 'foo')
};
ok $@, 'missing required attrib "percentage" dies ok';

done_testing
