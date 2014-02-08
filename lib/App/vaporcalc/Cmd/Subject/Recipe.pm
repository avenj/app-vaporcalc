package App::vaporcalc::Cmd::Subject::Recipe;

use Defaults::Modern;

use App::vaporcalc::RecipeResultSet;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);

method _action_show { $self->_action_view }
method _action_view {
  # Return a RecipeResultSet for frontend to format/display:
  App::vaporcalc::RecipeResultSet->new(recipe => $self->recipe)
}

method _action_save {
  # FIXME require a path, save RecipeResultSet to specified path
}

method _action_load {
  # FIXME attempt to load a RecipeResultSet and extract recipe
}

1;
