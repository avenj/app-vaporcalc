package App::vaporcalc::Role::Store;

use Defaults::Modern;

use JSON::MaybeXS ();

use Role::Tiny;

method save ( (Str | Path) $path ) {
  unless ($self->can('TO_JSON')) {
    confess "No TO_JSON method found for ".blessed $self
  }

  my $jseng = JSON::MaybeXS->new(
    utf8   => 1,
    pretty => 1,
    allow_blessed   => 1,
    convert_blessed => 1,
  );

  my $json  = $jseng->encode($self);
  unless ($json) {
    confess "Could not encode JSON: ".$jseng->error
  }

  path($path)->spew_utf8($json)
}

method load ( (Str | Path) $path ) {
  my $json  = path($path)->slurp_utf8;
  my $jseng = JSON::MaybeXS->new(utf8 => 1);
  my $data  = $jseng->decode($json);
  unless ($data) {
    confess "Could not decode JSON: ".$jseng->error
  }

  (blessed $self || $self)->new(%$data)
}

1;

=pod

=head1 NAME

App::vaporcalc::Role::Store

=head1 SYNOPSIS

  # See App::vaporcalc::Recipe, App::vaporcalc::RecipeResultSet
  use Moo;
  with 'App::vaporcalc::Role::Store';

=head1 DESCRIPTION

This role provides L</save> and L</load> methods that attempt to serialize or
retrieve objects via L<JSON::MaybeXS>; this is used by
L<App::vaporcalc::Recipe> & L<App::vaporcalc::RecipeResultSet> to preserve
e-liquid recipes.

=head2 save

Takes a path (as a string or a L<Path::Tiny> object) and attempts to serialize
the C<$self> object to the given path.

Objects are expected to provide their own C<TO_JSON> method; if it is not
available, an exception is thrown.

=head2 load

Takes a path (as a string or a L<Path::Tiny> object) and attempts to create a
new object by calling C<new()>.

(Usually called as a class method.)

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
