#!/usr/bin/perl

use Test::Simple tests => 6;
use strict;
use warnings;

use lib qw( lib ../lib );

use My::Google::Scholar;
use YAML qw(LoadFile);

my $scholar = My::Google::Scholar->new( { num => 100,
					  as_subj => 'eng' });


my $papers = LoadFile('Marc Schoenauer-papers.yaml');
my $sorted_papers = $scholar->sort_papers( $papers );

my $h_index = $scholar->h_index( $sorted_papers );
ok( $h_index >= 22, "Marc's h_index is OK" );

my $cites = $scholar->references( $sorted_papers );
ok( $cites >= 1865, "Marc's number of references is OK" );

my $g_index = $scholar->g_index( $sorted_papers );
ok( $g_index >= 40, "Marc's g_index is OK" );

$papers = LoadFile('santi.yaml');
$h_index = $scholar->h_index( $papers, 'No' );
ok( $h_index == 1, "Santiago's h_index is OK" );

$cites = $scholar->references( $papers );
ok( $cites == 1, "Santiago's number of references is OK" );

$g_index = $scholar->g_index( $papers, 'No' );
ok( $g_index == 1, "Santiago's g_index is OK" );

