package App::vaporcalc::Role::UI::PrepareCmd;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Module::Runtime 'use_module';

use Moo::Role;

has cmd_class_prefix => (
  lazy    => 1,
  is      => 'ro',
  isa     => Str,
  builder => sub { 'App::vaporcalc::Cmd::Subject::' },
);

method prepare_cmd (
  Str           :$subject,
  (Str | Undef) :$verb = undef,
  ArrayObj      :$params,
  RecipeObject  :$recipe,
) {
  
  # 'nic base' -> NicBase, etc
  my $fmt_subj = join '', map {; ucfirst } split ' ', lc $subject;
  my $mod = 'App::vaporcalc::Cmd::Subject::'.$fmt_subj;

  use_module($mod)->new(
    maybe verb   => $verb,
          params => $params,
          recipe => $recipe,
  )
}

1;
