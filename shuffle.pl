#!/usr/bin/perl

# 3. "Shuffle" files
#     a. is there a .new file and does it have a processing completed as last line?
#        if so, move catalog file to .old and move .new to current
#     b. if new exists and no processing completed message then remove it

use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use DMB::Tools ':all';
use Tie::File;

my $catalog_directory = "$ENV{HOME}/filey";
my $data_file = "$catalog_directory/nfull.cat";
my $completed_message = 'processing completed';

sub get_last_line {
    my ($filename) = @_;

    tie my @array, 'Tie::File', $filename or die "Can't tie $filename: $!";
    my $last = $array[-1];
    untie @array;

    return $last;
}

sub shuffle {
    my ($file) = @_;
    my $new_file = "$file.new";
    return if ! -f $new_file;
    my $last = get_last_line($new_file);
    print "shuffling $file {$last}...\n";
    if ( $last eq $completed_message ) {
        my $old_file = "$file.old";
        unlink $old_file;
        rename $file, $old_file or die "Couldn't move $file to $old_file: !$";
        rename $new_file, $file or die "Couldn't move $new_file to $file: !$";
    }
    else {
        unlink $new_file;
    }
    return;
}

sub main {
    my @argv = @_;
    shuffle($data_file);
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

