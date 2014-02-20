package App::vaporcalc::Cmd::Result;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Moo; use MooX::late;

has action => (
  lazy      => 1,
  is        => 'ro',
  isa       => CommandAction,
  builder   => sub {
    my ($self) = @_;
      $self->has_recipe    ? 'recipe'
    : $self->has_resultset ? 'display'
    : $self->has_prompt    ? 'prompt'
    :                        'print'
  },
);


has string => (
  lazy      => 1,
  is        => 'ro',
  isa       => Str,
  predicate => 1,
  builder   => sub { '' },
);


has prompt => (
  lazy      => 1,
  is        => 'ro',
  isa       => Str,
  predicate => 1,
  builder   => sub { '(undef)' },
);

has prompt_callback => (
  lazy      => 1,
  is        => 'ro',
  isa       => CodeRef,
  predicate => 1,
  builder   => sub { sub {} }
);

has prompt_default_ans => (
  lazy      => 1,
  is        => 'ro',
  isa       => Str,
  predicate => 1,
  builder   => sub { '' },
);

method run_prompt_callback (Str $answer = '') {
  chomp $answer;
  $self->prompt_callback->(
    local $_ = $answer || $self->prompt_default_ans || undef
  )
}


has recipe => (
  lazy      => 1,
  is        => 'ro',
  isa       => RecipeObject,
  coerce    => 1,
  predicate => 1,
);


has resultset => (
  lazy      => 1,
  is        => 'ro',
  isa       => RecipeResultSet,
  predicate => 1,
);


1;
