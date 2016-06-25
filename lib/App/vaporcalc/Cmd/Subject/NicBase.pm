package App::vaporcalc::Cmd::Subject::NicBase;

use Defaults::Modern;

use Moo;

method _subject { 'nic base' }


with 'App::vaporcalc::Role::UI::Cmd';

method _build_verb { 'show' }


method _action_show { $self->_action_view }
method _action_view {
  my $nbase = $self->recipe->base_nic_per_ml;
  $self->create_result(
    string => " -> Nic base: $nbase mg/ml"
  )
}

method _action_set {
  my $newbase = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $newbase;

  my $recipe = $self->munge_recipe(
    base_nic_per_ml => $newbase
  );
  $self->create_result(
    recipe => $recipe
  )
}

1;
