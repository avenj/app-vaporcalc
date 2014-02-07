package App::vaporcalc::Role::UI::Cmd;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use App::vaporcalc::Exception;
use App::vaporcalc::Recipe;

use Moo::Role;

has verb => (
  is       => 'ro',
  isa      => Str,
  builder  => sub { '' },
);

has params => (
  is       => 'ro',
  isa      => ArrayObj,
  coerce   => 1,
  builder  => sub { array },
);

has recipe => (
  required  => 1,
  is        => 'ro',
  isa       => RecipeObject,
  coerce    => 1,
  predicate => 'has_recipe',
  writer    => '_set_recipe',
);

method execute {
  App::vaporcalc::Exception->throw(
    message => 'Missing verb; no action to perform!'
  ) unless $self->verb;

  my $meth = '_action_'.lc $self->verb; 
  if ($self->can($meth)) {
    return $self->$meth
  }

  App::vaporcalc::Exception->throw(
    message => 'Unknown action: '.$self->verb
  )
}

method throw_exception (@params) {
  App::vaporcalc::Exception->throw(@params)
}

method munge_recipe (RecipeObject $recipe, %params) {
  my $data = $recipe->TO_JSON;
  $data{$_} = $params{$_} for keys %params;

  App::vaporcalc::Recipe->new(%$data)
}

1;
