#!/usr/bin/perl -w
use strict;

use lib './t';
use Test::More tests => 7;

###########################################################

	use WWW::UCC;
	my $obj = new WWW::UCC();

	my ($start,$final,$offset,$value) = ('100.00',140,10);

	$value = $obj->convert(
                  'source' => 'GBP',
                  'target' => 'EUR',
                  'value'  => $start,
                  'format' => 'number');

	SKIP: {
		skip	"Cannot access XE.com - are you connected to the internet?",
				7	unless(defined $value);

		# have to account for currency fluctuations
		is($value > ($final - $offset),1);
		is($value < ($final + $offset),1);

		$value = $obj->convert(
                  'source' => 'GBP',
                  'target' => 'EUR',
                  'value'  => $start,
                  'format' => 'text');
		ok(($value =~ /\d+\.\d+ Euro/ ? 1 : 0));

		$value = $obj->convert(
                  'source' => 'GBP',
                  'target' => 'EUR',
                  'value'  => $start);
		# have to account for currency fluctuations
		is($value > ($final - $offset),1);
		is($value < ($final + $offset),1);

		$value = $obj->convert(
                  'source' => 'GBP',
                  'target' => 'GBP',
                  'value'  => $start);
		is($value,$start);	# no conversion, should be the same

		$value = $obj->convert(
                  'source' => 'GBP',
                  'target' => 'GBP',
                  'value'  => $start,
                  'format' => 'text');
		ok(($value =~ /\d+\.\d+ British Pounds/ ? 1 : 0));
	}

###########################################################

