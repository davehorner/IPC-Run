#!/usr/bin/perl -w

=head1 NAME

timer.t - Test suite for IPC::Run::Timer

=cut

use strict ;

use Test ;

use IPC::Run ;
use IPC::Run::Timer qw( :all ) ;
use UNIVERSAL qw( isa ) ;

my $t ;
my $started ;

# $IPC::Run::debug = 2 ;

my @tests = (

sub {
   $t = timer(
#      debug => 1,
      1,
   ) ;
   ok( ref $t, 'IPC::Run::Timer' ) ;
},

sub { ok( $t->interval, 1 ) },

sub { $t->interval(  0          ) ;  ok( $t->interval,      0 ) },
sub { $t->interval(  0.1        ) ;  ok( $t->interval >     0 ) },
sub { $t->interval(  1          ) ;  ok( $t->interval >=    1 ) },
sub { $t->interval( 30          ) ;  ok( $t->interval >=   30 ) },
sub { $t->interval( 30.1        ) ;  ok( $t->interval >    30 ) },
sub { $t->interval( 30.1        ) ;  ok( $t->interval <=   31 ) },

sub { $t->interval( "1:0"       ) ;  ok( $t->interval,     60 ) },
sub { $t->interval( "1:0:0"     ) ;  ok( $t->interval,   3600 ) },
sub { $t->interval( "1:1:1"     ) ;  ok( $t->interval,   3661 ) },
sub { $t->interval( "1:1:1.1"   ) ;  ok( $t->interval >  3661 ) },
sub { $t->interval( "1:1:1.1"   ) ;  ok( $t->interval <= 3662 ) },
sub { $t->interval( "1:1:1:1"   ) ;  ok( $t->interval,  90061 ) },

sub {
   $t->reset ;
   $t->interval( 5 ) ;
   $t->start( 1, 0 ) ;
   ok( ! $t->is_expired ) ;
},
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },

sub { ok( !! $t->check( 0 ) ) },
sub { ok( !  $t->is_expired ) },
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !! $t->check( 1 ) ) },
sub { ok( !  $t->is_expired ) },
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !  $t->check( 2 ) ) },
sub { ok( !! $t->is_expired ) },
sub { ok( !  $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !  $t->check( 3 ) ) },
sub { ok( !! $t->is_expired ) },
sub { ok( !  $t->is_running ) },
sub { ok( !  $t->is_reset   ) },

## Restarting from the expired state.
sub {
   $t->start( undef, 0 ) ;
   ok( ! $t->is_expired ) ;
},
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },

sub { ok( !! $t->check( 0 ) ) },
sub { ok( !  $t->is_expired ) },
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !! $t->check( 1 ) ) },
sub { ok( !  $t->is_expired ) },
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !  $t->check( 2 ) ) },
sub { ok( !! $t->is_expired ) },
sub { ok( !  $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !  $t->check( 3 ) ) },
sub { ok( !! $t->is_expired ) },
sub { ok( !  $t->is_running ) },
sub { ok( !  $t->is_reset   ) },

## Restarting while running
sub {
   $t->start( 1, 0 ) ;
   $t->start( undef, 0 ) ;
   ok( ! $t->is_expired ) ;
},
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },

sub { ok( !! $t->check( 0 ) ) },
sub { ok( !  $t->is_expired ) },
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !! $t->check( 1 ) ) },
sub { ok( !  $t->is_expired ) },
sub { ok( !! $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !  $t->check( 2 ) ) },
sub { ok( !! $t->is_expired ) },
sub { ok( !  $t->is_running ) },
sub { ok( !  $t->is_reset   ) },
sub { ok( !  $t->check( 3 ) ) },
sub { ok( !! $t->is_expired ) },
sub { ok( !  $t->is_running ) },
sub { ok( !  $t->is_reset   ) },

) ;



plan tests => scalar @tests ;

$_->() for ( @tests ) ;

