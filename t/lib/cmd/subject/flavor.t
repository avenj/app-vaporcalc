use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Cmd::Subject::Flavor;
use App::vaporcalc::Recipe;

my $recipe = App::vaporcalc::Recipe->new(
  target_quantity   => 30,
  base_nic_per_ml   => 36,
  target_nic_per_ml => 12,
  target_pg         => 65,
  target_vg         => 35,
  flavor_percentage => 20,
);

my $cmd = App::vaporcalc::Cmd::Subject::Flavor->new(
  recipe => $recipe
);

ok $cmd->does('App::vaporcalc::Role::UI::Cmd'),
  'does Role::UI::Cmd';

ok $cmd->verb eq 'show', 'default verb ok';

my $res = $cmd->execute;
ok $res->action eq 'print', 'default verb cmd action ok';
like $res->string, qr/20/,  'default verb string';

$cmd = App::vaporcalc::Cmd::Subject::Flavor->new(
  recipe => $recipe,
  verb   => 'set',
  params => [ 10 ],
);
$res = $cmd->execute;
ok $res->action eq 'recipe', 'set verb cmd action ok';
my $new = $res->recipe;
isa_ok $new, 'App::vaporcalc::Recipe';
ok $new->flavor_percentage == 10,
  'set verb execute ok';

done_testing
