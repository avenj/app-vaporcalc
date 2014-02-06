package App::vaporcalc::Cmd;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

has subject_list => (
  is        => 'ro',
  isa       => TypedArray[Str],
  coerce    => 1,
  builder   => sub { 
    array_of Str() => (
      'nic base',
      'nic target',
      'flavor',
      'notes',
      'pg',
      'vg',
      'total',
    )
  },
);

has verb_list => (
  is        => 'ro',
  isa       => TypedArray[Str],
  coerce    => 1,
  builder   => sub { 
    array_of Str() => (
      'view',
      'del',
      'add',
      'set',
      'clear',
    )
  },
);

has default_verb => (
  is        => 'ro',
  isa       => Str,
  builder   => sub { 'view' },
);

with 'App::vaporcalc::Role::UI::ParseCmd';

1;
