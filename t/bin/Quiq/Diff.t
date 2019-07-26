#!/usr/bin/env perl

package Quiq::Diff::Test;
use base qw/Quiq::Test::Class/;

use strict;
use warnings;
use v5.10.0;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Quiq::Diff');
}

# -----------------------------------------------------------------------------

package main;
Quiq::Diff::Test->runTests;

# eof
