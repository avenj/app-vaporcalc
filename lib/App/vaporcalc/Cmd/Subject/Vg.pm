package App::vaporcalc::Cmd::Subject::Vg;

use Defaults::Modern;

use Moo; use MooX::late;

sub subject { 'vg' }

with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);


method _action_show { $self->_action_view }
method _action_view {
  my $vg = $self->recipe->target_vg;
  $self->create_result(string => " -> VG: $vg %")
}

method _action_set {
  my $new_vg = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $new_vg;

  my $new_pg = 100 - $new_vg;

  my $recipe = $self->munge_recipe(
    target_vg => $new_vg,
    target_pg => $new_pg
  );
  $self->create_result(recipe => $recipe)
}

1;
