package Quiq::Database::Config;
use base qw/Quiq::Config/;

use strict;
use warnings;
use v5.10.0;

our $VERSION = '1.156';

use Quiq::Hash;

# -----------------------------------------------------------------------------

=encoding utf8

=head1 NAME

Quiq::Database::Config - Datenbank-Konfiguration

=head1 BASE CLASS

L<Quiq::Config>

=head1 DESCRIPTION

Die Klasse kapselt den Zugriff auf eine Konfigurationsdatei, in
der Eingenschaften von einer oder mehrerer Datenbanken hinterlegt sind.
Es können prinzipiell beliebige Eigenschaften spezifiziert werden.
Speziell wird die Abfrage des Universal Database Locators (UDL)
unterstützt. Die Datei darf wegen etwaig enthaltener Passwörter
nur für den Owner lesbar/schreibbar sein.

=head2 Aufbau der Konfigurationsdatei

    '<database>' => {
        udl => '<udl>',
        ...
    },
    ...

=over 2

=item *

<database> ist ein beliebger Bezeichner.

=item *

<udl> ist der UDL der Datenbank.

=item *

Der Konfigurationshash {...} wird im Konstruktor zu einem
ungelockten %<Quiq::Hash> gemacht. Entsprechend können die Methoden
dieser Klasse zum Lesen der Konfigurationseinträge genutzt werden.

=back

=head1 EXAMPLE

    use Quiq::Database::Config;
    
    $cfg = Quiq::Database::Config->new('~/project/ocean/database.conf');
    $udl = $cfg->udl('test_db');

=head1 METHODS

=head2 Klassenmethoden

=head3 new() - Konstruktor

=head4 Synopsis

    $cfg = $class->new;
    $cfg = $class->new($file);

=head4 Arguments

=over 4

=item $file (Default: '~/.database.conf')

Konfigurationsdatei

=back

=head4 Returns

Objekt

=head4 Description

Instantiiere ein Objekt der Klasse und liefere eine Referenz auf dieses
Objekt zurück.

=cut

# -----------------------------------------------------------------------------

sub new {
    my $class = shift;
    my $file = shift // '~/.database.conf';

    my $self = $class->SUPER::new($file,
        -secure => 1,
    );
    $self->set(configFile=>$file);

    for (keys %$self) {
        $self->{$_} = Quiq::Hash->new($self->{$_})->unlockKeys;
    }

    return $self;
}

# -----------------------------------------------------------------------------

=head2 Objektmethoden

=head3 udl() - Universal Database Locator zu Datenbankname

=head4 Synopsis

    $udl = $class->udl($database);

=head4 Arguments

=over 4

=item $database

Name der Datenbank (String).

=back

=head4 Returns

Universal Database Locator (String).

=head4 Description

Ermittele den Universal Database Locator (UDL) für Datenbank $database
und liefere diesen zurück.

=cut

# -----------------------------------------------------------------------------

sub udl {
    my ($self,$database) = @_;

    my $h = $self->try($database) // $self->throw(
        'CONFIG-00001: Database not defined in config file',
        ConfigFile => $self->configFile,
        Database => $database,
    );

    my $udl = $h->try('udl') // $self->throw(
        'CONFIG-00002: UDL not defined for database',
        ConfigFile => $self->configFile,
        Database => $database,
    );

    return $udl;
}

# -----------------------------------------------------------------------------

=head1 VERSION

1.156

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
