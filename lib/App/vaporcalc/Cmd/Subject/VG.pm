package App::vaporcalc::Cmd::Subject::VG;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use App::vaporcalc::Exception;
use App::vaporcalc::Recipe;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);


method _action_show { $self->_action_view }
method _action_view {
  my $vg = $self->recipe->vg;
  " -> VG: $vg %"
}

method _action_set {
  my $new_vg = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $new_vg;

  $self->munge_recipe(
    $self->recipe,
    vg => $new_vg
  )
}

1;
