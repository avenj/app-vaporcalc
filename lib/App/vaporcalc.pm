package App::vaporcalc;
use Defaults::Modern;

use App::vaporcalc::Recipe;

# Want to plug in:
#   - base nic         (default 100mg/ml)
#   - target nic       (default 16mg/ml)
#   - target quantity  (default 10ml)
#   - PG %             (default 65% - conv to ml via target qty)
#   - VG %             (default 35% - conv to ml via target qty)
#   - Flavor %         (default 20% - conv to ml via target qty)
#
# Want to get:
#   - nic base total ml
#   - PG total ml
#   - VG total ml
#   - flavor total ml

# Feature list:
#   - recipe creation / storage
#

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
