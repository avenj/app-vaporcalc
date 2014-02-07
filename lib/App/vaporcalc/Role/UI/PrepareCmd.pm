package App::vaporcalc::Role::UI::PrepareCmd;

use Defaults::Modern
  -with_types => [ 'App::vaporcalc::Types' ];

use Module::Runtime 'use_module';

use Role::Tiny;

method prepare_cmd (
  Str          :$subject,
  Str          :$verb,
  ArrayObj     :$params,
  RecipeObject :$recipe,
) {
  
  # 'nic base' -> NicBase, etc
  my $fmt_subj = join '', map {; ucfirst } split ' ', lc $subject;
  my $mod = 'App::vaporcalc::Cmd::Subject::'.$fmt_subj;

  use_module($mod)->new(
    verb   => $verb,
    params => $params,
    recipe => $recipe,
  )
}

1;
