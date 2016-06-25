package App::vaporcalc::Cmd::Subject::NicType;

use Defaults::Modern;

use Moo; use MooX::late;

method _subject { 'nic type' }


with 'App::vaporcalc::Role::UI::Cmd';

method _build_verb { 'show' }


method _action_show { $self->_action_view }
method _action_view {
  my $type = $self->recipe->base_nic_type;
  $self->create_result(
    string => " -> Nic type: $type"
  )
}

method _action_set {
  my $new_nic = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $new_nic;

  my $recipe = $self->munge_recipe(
    base_nic_type => $new_nic
  );
  $self->create_result(
    recipe => $recipe,
  )
}

1;
