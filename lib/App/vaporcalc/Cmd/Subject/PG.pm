package App::vaporcalc::Cmd::Subject::PG;

use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';


has '+verb' => (
  builder => sub { 'show' },
);


method _action_show { $self->_action_view }
method _action_view {
  my $pg = $self->recipe->pg;
  " -> PG: $pg %"
}

method _action_set {
  my $new_pg = $self->params->get(0);
  $self->throw_exception(
    message => "set requires a parameter"
  ) unless defined $new_pg;

  $self->munge_recipe(
    $self->recipe,
    pg => $new_pg
  )
}


1;
