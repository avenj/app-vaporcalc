package App::vaporcalc::Cmd::Subject::Vg;

use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';


has '+verb' => (
  builder => sub { 'show' },
);


method _action_show { $self->_action_view }
method _action_view {
  my $vg = $self->recipe->target_vg;
  " -> VG: $vg %"
}

method _action_set {
  my $new_vg = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $new_vg;

  my $new_pg = 100 - $new_vg;

  $self->munge_recipe(
    target_vg => $new_vg,
    target_pg => $new_pg
  )
}

1;
