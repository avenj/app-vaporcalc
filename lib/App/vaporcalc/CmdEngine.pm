package App::vaporcalc::CmdEngine;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;

has subject_list => (
  is        => 'ro',
  isa       => ArrayObj,
  coerce    => 1,
  builder   => sub {
    array(
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
    )
  },
);

with 'App::vaporcalc::Role::UI::ParseCmd',
     'App::vaporcalc::Role::UI::PrepareCmd';

1;
