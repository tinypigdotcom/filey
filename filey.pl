#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use DMB::Tools ':all';
use Tie::File;

my $catalog_directory = "$ENV{HOME}/filey";
my $data_file = "$catalog_directory/nfull.cat";
sub shuffle {
    my ($file) = @_;
    my $new_file = "$file.new";
    return if ! -f $new_file;
    my $last = get_last_line($new_file);
    print "shuffling $file {$last}...\n";
}

sub proc_msg {
    my $completed_message = join ' ', split '', 'processing completed';
    print "$completed_message\n";
}

sub get_last_line {
    my ($filename) = @_;

    tie my @array, 'Tie::File', $filename or die "Can't tie $filename: $!";
    my $last = $array[-1];
    untie @array;

    return $last;
}

sub main {
    my @argv = @_;
    proc_msg();
    shuffle($data_file);
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

