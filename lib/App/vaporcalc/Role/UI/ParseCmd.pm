package App::vaporcalc::Role::UI::ParseCmd;

use Defaults::Modern;

use Role::Tiny;
requires qw/
  subject_list
  verb_list
/;


method parse_cmd (Str $str) {
  # e.g.:
  #   set nic base 100
  #   nic base set 100
  my ($subj, $verb, $params);

  SUBJ: for my $maybe (@{ $self->subject_list }) {
    my $idx = index $str, $maybe;
    next SUBJ if $idx == -1;
    # Found subject:
    $subj = $maybe;
    substr $str, $idx, length($maybe), '';
    # ' VERB PARAMS' or 'VERB  PARAMS'
    # trim leading, trailing, double whitespace
    if (length $str) {
      $str =~ s/^\s+//;
      $str =~ s/\s+\z//;
      $str =~ s/ {2}/ /g;
    } else {
      if ($self->can('default_verb') && my $default = $self->default_verb) {
        $str = $default
      } else {
        App::vaporcalc::Exception->throw(
          message => "No verb found and no default_verb available",
        );
      }
    }
    my @pieces = split ' ', $str;
    $verb = shift @pieces;
    $params = array(@pieces);
  }
  unless ($subj) {
    App::vaporcalc::Exception->throw(
      message => "No subject to operate on",
    )
  }
  unless ($verb) {
    App::vaporcalc::Exception->throw(
      message => "No action to perform"
    )
  }

  hash(
    subject => $subj,
    verb    => $verb,
    params  => $params
  )->inflate
}


1;
