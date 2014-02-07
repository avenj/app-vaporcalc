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


=pod

=head1 NAME

App::vaporcalc - Calculate e-liquid recipes for DIY vaping

=head1 SYNOPSIS

FIXME

=head1 WARNING

B<< Nicotine is dangerous; skin contact can kill you. >>

B<< Don't play with it if you don't respect it! >>

=head1 DESCRIPTION

FIXME description, links to UIs, overview / links to modules

=head1 TIPS

Less is more with many flavors; you may want to start around 5% or so and work
your way up.

Ideally, let juices steep for at least a day before sampling; shaking and
warmth can help steep flavors faster.

Don't use flavors containing diacetyl (frequently used to create a buttery
taste). It's safe to eat, not safe to vape.

Anything containing artifical coloring or triglycerides is probably not safe
to vape.

Flavors containing triacetin are reported to cause cracking in various plastic
tanks. Triacetin is a reasonable flavor carrier and probably OK to vape, but
may be rough on equipment.

Buy nicotine from a reputable supplier and test it; there have been instances
of nicotine solutions marketed as 100mg/ml going as high as 250mg/ml!

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut

# vim: ts=2 sw=2 et sts=2 ft=perl
