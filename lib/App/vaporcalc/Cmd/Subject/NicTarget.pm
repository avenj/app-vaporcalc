package App::vaporcalc::Cmd::Subject::NicTarget;

use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'view' },
);

method _action_show { $self->_action_view }
method _action_view {
  my $ntarget = $self->recipe->target_nic_per_ml;
  " -> Target nicotine: $ntarget mg/ml"
}

method _action_set {
  my $newnic = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $newnic;

  $self->munge_recipe(
    $self->recipe,
    target_nic_per_ml => $newnic,
  )
}

1;
