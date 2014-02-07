#!/usr/bin/perl
use warnings;

use LWP::Simple;

# Now carve some details out of this one
my $content = get("http://192.168.100.1/RgConnect.asp") or die "Could not get page- $!\n";

foreach my $line (split("\n", $content)){

	# <tr><td>1</td><td>Locked</td><td>QAM256</td><td>37</td><td>837000000 Hz</td><td> 1.0 dBmV</td><td>41.4 dB</td><td>7</td><td>0</td></tr>
	if ($line =~ /<tr><td>(\d)<\/td><td>(.*?)<\/td><td>(.*?)<\/td><td>(\d+)<\/td><td>(\d+) Hz<\/td><td>.*?(\d+\.\d+) dBmV<\/td><td>.*?(\d+\.\d+) dB<\/td><td>(\d+)<\/td><td>(\d+)<\/td><\/tr>/i){ 
		print "surfboard_stats=downchannel channel=$1 lock_status=$2 modulation=$3 channel_id=$4 freq=$5 power_level_dBmV=$6 signal_to_noise_ratio_dB=$7 correctables=$8 uncorrectables=$9\n";
		}
	};


