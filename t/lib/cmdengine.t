use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::CmdEngine;
use App::vaporcalc::Recipe;

my $cmdeng = App::vaporcalc::CmdEngine->new;

ok $cmdeng->does('App::vaporcalc::Role::UI::ParseCmd'),
  'does Role::UI::ParseCmd';
ok $cmdeng->does('App::vaporcalc::Role::UI::PrepareCmd'),
  'does Role::UI::PrepareCmd';

my @subject_consistency_chk = (
  'help',
  'recipe',
  'target amount',
  'flavor',
  'flavor type',
  'nic base',
  'nic target',
  'nic type',
  'pg',
  'vg',
  'notes',
);

ok $cmdeng->subject_list->count == @subject_consistency_chk,
  'subject_list has expected element count';

for my $subj (@subject_consistency_chk) {
  ok $cmdeng->subject_list->has_any(sub { $_ eq $subj }),
    "subject_list has $subj";
}

done_testing
