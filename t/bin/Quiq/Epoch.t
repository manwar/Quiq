#!/usr/bin/env perl

package Quiq::Epoch::Test;
use base qw/Quiq::Test::Class/;

use strict;
use warnings;
use v5.10.0;
use utf8;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Quiq::Epoch');
}

# -----------------------------------------------------------------------------

sub test_new : Test(4) {
    my $self = shift;

    # ohne Parameter
    
    my $t = Quiq::Epoch->new;
    $self->is(ref($t),'Quiq::Epoch');
    $self->ok($$t >= time);

    # mit Epoch-Wert

    $t = Quiq::Epoch->new(12345678);
    $self->is($$t,12345678);

    # mit ISO-Zeitangabe (Wert hängt von lokaler Zeitzone ab)

    $t = Quiq::Epoch->new('2019-06-02 11:12:31');
    $self->ok($$t > 1559400000);
}

# -----------------------------------------------------------------------------

sub test_epoch : Test(1) {
    my $self = shift;

    my $epoch = Quiq::Epoch->new->epoch;
    $self->ok($epoch >= time);
}

# -----------------------------------------------------------------------------

sub test_localtime : Test(4) {
    my $self = shift;

    my @arr = Quiq::Epoch->new(1559466751)->localtime;
    $self->is($arr[0],31);
    $self->is($arr[1],12);
    $self->is($arr[4],6);
    $self->is($arr[5],2019);
}

# -----------------------------------------------------------------------------

sub test_as : Test(1) {
    my $self = shift;

    $ENV{'TZ'} = 'CET'; # Fix: CPAN Testers

    my $str = Quiq::Epoch->new(1464342621.73231)->as('YYYY-MM-DD HH:MI:SS');
    $self->is($str,'2016-05-27 11:50:21');
}

# -----------------------------------------------------------------------------

package main;
Quiq::Epoch::Test->runTests;

# eof
