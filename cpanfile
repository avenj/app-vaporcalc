requires "Defaults::Modern" => "0.007";
requires "Exporter::Tiny" => "0";
requires "JSON::MaybeXS" => "1.001";
requires "Term::ANSIColor" => "4";
requires "Term::ReadLine" => "0";
requires "Term::UI" => "0";
requires "Text::ParseWords" => "0";
requires "Throwable" => "0.2";

on 'test' => sub {
  requires "Test::Modern" => "0.002";
  requires "Test::More" => "0";
};
