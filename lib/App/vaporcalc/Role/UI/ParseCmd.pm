package App::vaporcalc::Role::UI::ParseCmd;

use Defaults::Modern;

use App::vaporcalc::Exception;

use Role::Tiny;
requires 'subject_list';


method parse_cmd (Str $str) {
  # e.g.:
  #   set nic base 100
  #   nic base set 100  
  my ($subj, $verb);
  my $params = array;

  SUBJ: for my $maybe (@{ $self->subject_list }) {
    my $idx = index $str, $maybe;
    next SUBJ if $idx == -1;
    no warnings 'substr';
    if ($idx > 0) {
      my $prevchar = substr $str, ($idx - 1), 1;
      next SUBJ unless $prevchar eq ' ';
    }
    if ( (my $pos = $idx + length($maybe)) < length $str ) {
      my $nextchar = substr $str, $pos, 1;
      next SUBJ unless $nextchar eq ' ';
    }
    $subj = $maybe;
    substr $str, $idx, length($maybe), ' ';
    my $pieces = array( split ' ', $str );
    $verb = $pieces->shift;
    $params = $pieces;
    last SUBJ
  }

  unless ($subj) {
    App::vaporcalc::Exception->throw(
      message => "No subject to operate on",
    )
  }

  hash(
    subject => $subj,
    verb    => $verb,
    params  => $params
  )->inflate
}


1;
