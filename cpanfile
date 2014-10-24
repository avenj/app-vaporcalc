requires "Defaults::Modern" => "0.007";
requires "Exporter::Tiny" => "0";
requires "JSON::MaybeXS" => "1.001";
requires "Term::ANSIColor" => "4";
requires "Term::ReadLine" => "0";
requires "Term::UI" => "0";
requires "Text::ParseWords" => "0";
requires "Throwable" => "0.2";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "Test::Modern" => "0.002";
  requires "Test::More" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::CPAN::Changes" => "0.19";
  requires "Test::More" => "0";
  requires "Test::NoTabs" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Synopsis" => "0";
};
