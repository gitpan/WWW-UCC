#!/usr/bin/perl -w
use strict;

use lib './t';
use Test::More	tests => 5;

###########################################################

	use WWW::UCC;
	my $obj = new WWW::UCC();
	isa_ok($obj,'WWW::UCC');

	my @currencies = $obj->currencies;
	is(scalar(@currencies),70);
	is($currencies[0] ,'ARS');
	is($currencies[24],'GBP');
	is($currencies[69],'ZMK');

###########################################################

