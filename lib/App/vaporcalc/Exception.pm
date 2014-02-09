package App::vaporcalc::Exception;

use Defaults::Modern;

use Moo; use MooX::late;
extends 'Throwable::Error';

1;

=pod

=head1 NAME

App::vaporcalc::Exception

=head1 SYNOPSIS

  use App::vaporcalc::Exception;
  App::vaporcalc::Exception->throw("died!")

=head1 DESCRIPTION

L<App::vaporcalc> exception objects.

A subclass of L<Throwable::Error>. Look there for details.

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
