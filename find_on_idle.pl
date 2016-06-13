#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

my $DEBUG_FAKE_IDLE=1;

use Data::Dumper;
use DMB::Tools ':all';
use File::Find;

my $search_dir = '/home/dbradford';
my $idle_file = '/cygdrive/c/idle';

sub is_idle {
    if ( -f $idle_file || $DEBUG_FAKE_IDLE ) {
        return 1;
    }
    else {
        return;
    }
}

sub wanted {
    print "$File::Find::name\n";
    if ( !is_idle() ) {
        exit;
    }
}

sub main {
    my @argv = @_;
    if ( is_idle() ) {
        print "Idle\n";
        find(\&wanted, $search_dir);
    }
    else {
        print "Not Idle\n";
    }
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

