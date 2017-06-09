#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

package Btree{
    sub new{
        my $class = shift;
        my $self = { t => 2,
                     @_,
        };
        $self->{root} = Node->new($self->{t});
        $self->{root}{is_leaf} = 1;

        bless $self, $class;
    }
    sub insert{
        my $self = shift;
        my $k = shift;
        my $r = $self->{root};
        $r->insert_nonfull($k);
    }
}

package Node{
    sub new{
        my $class = shift;
        my ($t) = @_;
        my $self = { 
            t => $t,
            keys => [],
            children => [],
            is_leaf => 0,
        };
        bless $self, $class;
    }

    sub insert_nonfull{
        my $self = shift;
        my $k    = shift;
        my $keys = $self->{keys};
        if ( $self->{is_leaf} ) {
            print main::Dumper $self;
            my $keys_cnt = scalar @$keys;
            print $keys_cnt;
            my $i = 0;
            for(my $i = 0; $i < $keys_cnt; $i++){
                if ($k < $keys->[$i]){
                    splice $keys, $i, 0, $k;
                    last;
                }
            }
            push @$keys, $k;
        }
        else{
            print "not leaf";
        }

    }
}

my $tree = Btree->new("t" => 2);
my $list = [];
for (1 .. 100){ push @$list, int( rand 100 ) }; 

foreach(@$list){
    $tree->insert($_);
}
