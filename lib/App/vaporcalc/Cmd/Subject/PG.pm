package App::vaporcalc::Cmd::Subject::PG;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use App::vaporcalc::Exception;
use App::vaporcalc::Recipe;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);

method execute {
  my $meth = '_action_'.lc $self->verb;
  if ($self->can($meth)) {
    return $self->$meth
  }
  App::vaporcalc::Exception->throw(
    message => "Unknown action: ".$self->verb
  )
}

method _action_show { $self->_action_view }
method _action_view {
  my $pg = $self->recipe->pg;
  " -> PG: $pg %"
}

method _action_set {
  my $new_pg = $self->params->get(0);
  App::vaporcalc::Exception->throw(
    message => "set requires a parameter"
  ) unless defined $new_pg;

  my $data = $recipe->TO_JSON;
  $data->{pg} = $new_pg;

  App::vaporcalc::Recipe->new(%$data);
}


1;
