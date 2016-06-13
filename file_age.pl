#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use DMB::Tools ':all';

sub days_old {
    my ($file) = @_;
    my $mtime= (stat $file)[9];
    my $time = time;
    my $diff = ($time - $mtime) / 60 / 60 / 24; # Number of days
    return $diff;
}

sub main {
    my @argv = @_;
    my $infile = '../.vimrc';
    my $days = days_old($infile);
    print "days {$days}\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

