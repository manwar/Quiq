package Quiq::Html;
use base qw/Quiq::Html::Helper/;

use strict;
use warnings;
use v5.10.0;

our $VERSION = '1.154';

# -----------------------------------------------------------------------------

=encoding utf8

=head1 NAME

Quiq::Html - Generierung von Tags und Tag-Konstrukten

=head1 BASE CLASS

L<Quiq::Html::Helper>

=head1 DESCRIPTION

Die Klasse dient der Generierung von einzelnen Tags oder einfachen
Konstrukten von Tags. Sie implementiert keine eigene Funktionalität,
sondern stellt die vereinigte Funktionalität der Klassen
Quiq::Html::Tag und Quiq::Html::Helper zur Verfügung, da sie
von diesen abgeleitet ist:

    Quiq::Html::Tag - einzelne HTML-Tags
             |

    Quiq::Html::Helper - einfache Konstrukte von Tags
              |
       Quiq::Html - vereinigte Funktionalität

Einfacher Anwendungsfall:

    my $h = Quiq::Html->new;
    
    my $html = Quiq::Html::Page->html($h,
        ...
    );

=head1 METHODS

=head2 Instantiierung

=head3 new() - Konstruktor

=head4 Synopsis

    $h = $class->new(@keyVal);
    $h = $class->new($htmlVersion,@keyVal);

=head4 Description

Instantiiere ein Objekt zur Generierung von HTML-Code und liefere eine
Referenz auf dieses Objekt zurück. Anmerkung: Dieser Konstruktor ist
in der Basisklasse Quiq::Html::Tag implementiert.

=head1 VERSION

1.154

=head1 AUTHOR

Frank Seitz, L<http://fseitz.de/>

=head1 COPYRIGHT

Copyright (C) 2019 Frank Seitz

=head1 LICENSE

This code is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

# -----------------------------------------------------------------------------

1;

# eof
