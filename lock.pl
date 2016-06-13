#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use DMB::Tools ':all';

my $lock_dir = '/tmp/d';
my $lock_succeeded = 0;

END {
    if ( $lock_succeeded ) {
        rmdir $lock_dir;
    }
    print "Ending.\n";
}

sub main {
    my @argv = @_;
    mkdir $lock_dir or die "Already running.";
    $lock_succeeded=1;
    sleep 9;
    print "I am d.pl\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

