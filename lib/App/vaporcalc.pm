package App::vaporcalc;

use Defaults::Modern;

use App::vaporcalc::Recipe;

use parent 'Exporter::Tiny';
our @EXPORT = our @EXPORT_OK = 'vcalc';

sub vcalc {
  my $recipe = App::vaporcalc::Recipe->new(@_);
  my $result = $recipe->calc;
  hash(
    recipe => $recipe,
    result => $result
  )->inflate
}


1;

# vim: ts=2 sw=2 et sts=2 ft=perl
