package App::vaporcalc::Cmd::Subject::NicType;

use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);

method _action_show { $self->_action_view }
method _action_view {
  my $type = $self->recipe->base_nic_type;
  " -> Nic type: $type"
}

method _action_set {
  my $new_nic = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $new_nic;

  $self->munge_recipe(
    $self->recipe,
    base_nic_type => $new_nic
  )
}

1;
