use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Cmd::Subject::NicTarget;
use App::vaporcalc::Recipe;

my $recipe = App::vaporcalc::Recipe->new(
  target_quantity   => 30,
  base_nic_per_ml   => 36,
  target_nic_per_ml => 12,
  target_pg         => 65,
  target_vg         => 35,
  flavor_percentage => 20,
);

my $cmd = App::vaporcalc::Cmd::Subject::NicTarget->new(
  recipe => $recipe
);

ok $cmd->does('App::vaporcalc::Role::UI::Cmd'),
  'does Role::UI::Cmd';

ok $cmd->verb eq 'show', 'default verb ok';

like $cmd->execute, qr{mg/ml}, 'default verb execute ok';

$cmd = App::vaporcalc::Cmd::Subject::NicTarget->new(
  recipe => $recipe,
  verb   => 'set',
  params => [ 16 ],
);
my $new = $cmd->execute;
isa_ok $new, 'App::vaporcalc::Recipe';
ok $new->target_nic_per_ml == 16,
  'set verb execute ok';

done_testing
