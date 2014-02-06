use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Exception;

eval {; App::vaporcalc::Exception->throw('foo bar!') };
my $err = $@;
isa_ok $err, 'App::vaporcalc::Exception';
ok $err->message eq 'foo bar!', 'message ok';
like "$err", qr/foo bar!/, 'stringification ok';

done_testing
