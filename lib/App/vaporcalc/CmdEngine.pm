package App::vaporcalc::CmdEngine;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;
use Module::Pluggable
  require     => 1,
  sub_name    => '_subjects',
  search_path => 'App::vaporcalc::Cmd::Subject',
  except      => [
    # stale (back-compat upon upgrade):
    'App::vaporcalc::Cmd::Subject::FlavorType',
  ],
;

has subject_list => (
  is        => 'ro',
  isa       => ArrayObj,
  coerce    => 1,
  builder   => sub {
    my ($self) = @_;
    [ 
      map {; 
        $_->can('_subject') ? $_->_subject
          : do { warn "No '_subject' defined for '$_'\n"; () }
      } $self->_subjects 
    ]
  },
);

with 'App::vaporcalc::Role::UI::ParseCmd',
     'App::vaporcalc::Role::UI::PrepareCmd';

1;

=pod

=head1 NAME

App::vaporcalc::CmdEngine

=head1 SYNOPSIS

  use App::vaporcalc::CmdEngine;
  my $help = App::vaporcalc::CmdEngine->prepare_cmd(
    subject => 'help',
  );
  # See App::vaporcalc::Role::UI::ParseCmd,
  #     App::vaporcalc::Role::UI::PrepareCmd

=head1 DESCRIPTION

A class containing a valid L</subject_list> for use with
B<vaporcalc> command handler roles; see L</CONSUMES>.

=head2 ATTRIBUTES

=head3 subject_list

The list of valid B<vaporcalc> subjects (as an
L<List::Objects::WithUtils::Array>).

Built by scanning classes in the C<App::vaporcalc::Cmd::Subject::> namespace
via L<Module::Pluggable>.

=head2 CONSUMES

L<App::vaporcalc::Role::UI::ParseCmd>

L<App::vaporcalc::Role::UI::PrepareCmd>

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
