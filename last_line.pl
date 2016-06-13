#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use DMB::Tools ':all';
use Tie::File;

sub get_last_line {
    my ($filename) = @_;

    tie my @array, 'Tie::File', $filename or die "Can't tie $filename: $!";
    my $last = $array[-1];
    untie @array;

    return $last;
}

sub main {
    my @argv = @_;
    my $filename = "$ENV{HOME}/data/full.cat";
    my $last = get_last_line($filename);
    print "last $last\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;


