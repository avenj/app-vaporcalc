package App::vaporcalc::Role::UI::Cmd;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use App::vaporcalc::Exception;
use App::vaporcalc::Recipe;
use App::vaporcalc::Cmd::Result;

use Moo::Role; use MooX::late;

has verb => (
  is       => 'ro',
  isa      => Str,
  builder  => sub { '' },
);

has params => (
  is       => 'ro',
  isa      => ArrayObj,
  coerce   => 1,
  builder  => sub { array },
);

has recipe => (
  required  => 1,
  is        => 'ro',
  isa       => RecipeObject,
  coerce    => 1,
  writer    => '_set_recipe',
);

method execute {
  App::vaporcalc::Exception->throw(
    message => 'Missing verb; no action to perform!'
  ) unless $self->verb;
  my $meth = '_action_'.lc $self->verb; 
  return $self->$meth if $self->can($meth);
  App::vaporcalc::Exception->throw(
    message => 'Unknown action: '.$self->verb
  )
}

method throw_exception (@params) {
  App::vaporcalc::Exception->throw(@params)
}

method create_result (%params) {
  App::vaporcalc::Cmd::Result->new(%params)
}

method munge_recipe (%params) {
  my $data = $self->recipe->TO_JSON;
  $data->{$_} = $params{$_} for keys %params;
  App::vaporcalc::Recipe->new(%$data)
}

1;

=pod

=head1 NAME

App::vaporcalc::Role::UI::Cmd - Helper for vaporcalc command objects

=head1 SYNOPSIS

  package App::vaporcalc::Cmd::Subject::Foo;
  use Moo;
  with 'App::vaporcalc::Role::UI::Cmd';

=head1 DESCRIPTION

A L<Moo::Role> providing attributes & behavior common to L<App::vaporcalc>
command objects.

=head2 ATTRIBUTES

=head3 verb

The action to perform.

An empty string by default. Consumers may want to override to provide a
default action.

=head3 params

The parameters for the command, as a L<List::Objects::Types/"ArrayObj">.

Can be coerced from a plain ARRAY.

=head3 recipe

The L<App::vaporcalc::Recipe> object being operated on.

Required by default.

=head2 METHODS

=head3 execute

A default dispatcher that, when called, converts L</verb> to lowercase and attempts to find
a method named C<< _action_$verb >>  to call.

=head3 throw_exception

  $self->throw_exception(
    message => 'failed!'
  );

Throw an exception object.

=head3 create_result

Builds an L<App::vaporcalc::Cmd::Result> instance.

=head3 munge_recipe

  my $new_recipe = $self->munge_recipe( 
    target_vg => 50, 
    target_pg => 50 
  );

Calls C<TO_JSON> on the current L</recipe> object, merges in the
given key/value pairs, and returns a new L<App::vaporcalc::Recipe> with the
appropriate values.

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
