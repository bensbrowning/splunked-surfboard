#!/usr/bin/perl
use warnings;
use strict;

use LWP::Simple;

my $content = get("http://192.168.100.1/RgSignal.asp") or die "Could not get page- $!\n";

my($power, $snr, $uppower) = ("undef", "undef", "undef");
foreach my $line (split("\n", $content)){

	# <tr><td>Power Level</td><td>1.0 dBmV<br>
	if ($line =~ /<td>Power Level<\/td><td>(.+) dBmV.+/i){ 
		$power=$1;
		}
	# <tr><td>Signal To Noise Ratio</td><td>41.4 dB</td><tr>
	elsif ($line =~ /<td>Signal To Noise Ratio<\/td><td>(.+) dB<\/td>/i){ 
		$snr=$1;
		}
	# <tr><td>Power</td><td>38.8 dBmV</td></tr>
	elsif ($line =~ /<td>Power<\/td><td>(.+) dBmV<\/td>/i){ 
		$uppower=$1;
		}
	};

print "power_level_dBmV=$power signal_to_noise_ratio_dB=$snr upstream_power_level_dBmV=$uppower\n";
