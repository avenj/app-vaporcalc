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
