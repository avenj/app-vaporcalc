package App::vaporcalc::CmdEngine;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;
use Module::Pluggable
  require     => 1,
  sub_name    => '_subjects',
  search_path => 'App::vaporcalc::Cmd::Subject',
  except      => [
    # stale version:
    'App::vaporcalc::Cmd::Subject::FlavorType',
  ],
;

has subject_list => (
  # don't make me lazy; tests expect possible warnings during instantiation
  is        => 'ro',
  isa       => ArrayObj,
  coerce    => 1,
  builder   => sub {
    my ($self) = @_;

    my %subj;
    SUBJ: for my $this_class ($self->_subjects) {
      unless ($this_class->can('_subject')) {
        warn 
          "No '_subject' defined for '$this_class' - ",
          "not added to subject_list";
        next SUBJ
      }

      my $this_subj = $this_class->_subject;

      if (my $prev = $subj{$this_subj}) {
        die "BUG -- subject conflict:\n",
            "Subject '$this_subj' defined by:\n '$prev'\n '$this_class'\n",
            "Cannot build subject_list!"
      }

      $subj{$this_subj} = $this_class;
    }  # SUBJ

    if (my @sorted = sort keys %subj) {
      return \@sorted
    }
    warn
      "No command subjects found in module search path; ",
      "namespace: 'App::vaporcalc::Cmd::Subject'";
    []
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
via L<Module::Pluggable> and collecting the results of calling their
respective C<_subject> methods.

=head2 CONSUMES

L<App::vaporcalc::Role::UI::ParseCmd>

L<App::vaporcalc::Role::UI::PrepareCmd>

=head1 SEE ALSO

L<App::vaporcalc::Role::UI::Cmd> contains an example command subject in the
SYNOPSIS.

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
