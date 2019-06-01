package Quiq::Database::Api;
use base qw/Quiq::Object/;

use strict;
use warnings;
use v5.10.0;

our $VERSION = '1.143';

use Quiq::Database::Api::Dbi::Connection;

# -----------------------------------------------------------------------------

=encoding utf8

=head1 NAME

Quiq::Database::Api - Lowlevel Datenbank-Schnittstelle

=head1 BASE CLASS

L<Quiq::Object>

=head1 DESCRIPTION

Eine grundlegende Datenbank-Schnittstelle Quiq::Database::Api::*
wird durch zwei Klassen definiert:

Quiq::Database::Api::*::Connection

    $db = $class->new($udlObj);  # Datenbankverbindung aufbauen
    $cur = $db->sql($stmt);      # SQL-Statement ausführen
    $db->destroy;                # Datenbankverbindung abbauen

Quiq::Database::Api::*::Cursor

    $cur = $class->new(@keyVal); # Curson instantiieren
    
    $n = $cur->bindVars;         # Anzahl Bind-Variablen
    $n = $cur->hits;             # Anzahl "Treffer"
    $id = $cur->id;              # Generierter Autoinkrement-Wert
    $titlesA = $cur->titles;     # Kolumnentitel
    
    $cur2 = $cur->bind(@vals);   # Platzhalter einsetzen
    $row = $cur->fetch;          # nächsten Datensatz lesen
    
    $cur->destroy;               # Cursor schließen

Die bislang einzige Lowlevel-Datenbank-Schnittstelle ist DBI, die
die beiden Klassen umfasst:

    Quiq::Database::Api::Dbi::Connection
    Quiq::Database::Api::Dbi::Cursor

Potentielle andere Lowlevel-Datenbank-Schnittstellen müssen
die gleichen Methoden implementieren.

=head1 METHODS

=head2 Verbindungsaufbau

=head3 connect() - Instantiiere Lowlevel-Datenbankverbindung

=head4 Synopsis

    $db = $class->connect($udlObj);

=head4 Description

Instantiiere eine Lowlevel-Datenbankverbindung auf Basis von
UDL-Objekt $udlObj und liefere eine Referenz auf die
Datenbankverbindung zurück.

=head4 Example

    use Quiq::Database::Api;
    
    my $udl = 'dbi#mysql:test%root';
    my $udlObj = Quiq::Udl->new($udl);
    my $db = Quiq::Database::Api->connect($udlObj);
    print ref($db),"\n";
    __END__
    Quiq::Database::Api::Dbi::Connection

=cut

# -----------------------------------------------------------------------------

sub connect {
    my $class = shift;
    my ($udlObj) = @_;

    my $apiName = ucfirst $udlObj->api;
    my $apiClass = $class.'::'.$apiName.'::Connection';

    return $apiClass->new(@_);
}

# -----------------------------------------------------------------------------

=head1 VERSION

1.143

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
