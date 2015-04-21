#!/usr/bin/env perl
use strict;
use utf8;
use warnings;
use Encode;
use JSON;
use JSON::Types;
use Getopt::Long;
use Search::Elasticsearch;

# hostname or IP address of the host to use for Elasticsearch
my $NODE = 'localhost:9200';
my %opts;
Getopt::Long::GetOptions(\%opts, qw( primary=s index=s type=s verbose) );
my $es = Search::Elasticsearch->new(node => $NODE);
my $bulk = $es->bulk_helper(
    index   => $opts{index},
    type    => $opts{type},
    verbose => 1
);

my @name;
while ( my $line = <STDIN> ) {
    chomp($line);
    my @columns = split("\t", $line);
    if ( @name ) {
        my $data;
        for my $i ( 0 .. $#name ){
            if ( $name[$i] ) {
                if ( $columns[$i] =~ /^-?\d+$/ ) {
                    $data->{ $name[$i] } = number $columns[$i];
                } 
                else {
                    $columns[$i] = decode_utf8($columns[$i]);
                    $data->{ $name[$i] } = $columns[$i];
                }
            }
        }
        my $json = encode_json($data) . "\n";
        $bulk->index({ id => $data->{$opts{primary}}, source => $json});
    }
    else {
         @name = @columns;
    }
}
$bulk->flush;
