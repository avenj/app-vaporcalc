package App::vaporcalc::CmdEngine;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::ParseCmd',
     'App::vaporcalc::Role::UI::PrepareCmd';

1;
