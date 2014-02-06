package App::vaporcalc;

use Defaults::Modern;

use App::vaporcalc::Recipe;
use App::vaporcalc::RecipeResultSet;

use parent 'Exporter::Tiny';
our @EXPORT = our @EXPORT_OK = 'vcalc';

sub vcalc {
  my $recipe = App::vaporcalc::Recipe->new(@_);
  App::vaporcalc::RecipeResultSet->new(recipe => $recipe)
}


1;

# vim: ts=2 sw=2 et sts=2 ft=perl
