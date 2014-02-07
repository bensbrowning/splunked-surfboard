#!/usr/bin/perl
use warnings;

use LWP::Simple;
use File::Copy;

$log = "$ENV{SPLUNK_HOME}/var/log/surfboard.log";
$url = "http://192.168.100.1/RgEventLog.asp";
# here come the logs!
my $content = get($url) || die "Could not get $url- $!\n";

open(O, ">$log.new") || die "Can't open $log - $!\n";
foreach my $line (split("\n", $content)) {
	next unless ($line =~ s/.+<td align="center"><b><font color="white">Description<\/font>.+?<\/tr>(.+)<\/table>/$1/);
	foreach my $entry (split("</tr>", $line)){
		# <tr bgcolor=white><td>2014-01-23 03:06:57</td><td>3-Critical</td><td>DHCP FAILED - Discover sent, no offer received;CM-MAC=a4:7a:a4:72:4a:7d;CMTS-MAC</td></tr>
		$entry =~ /.+?([\d-]+ [\d:]+)<\/td><td>\d-(\w+)<\/td><td>(.+)<\/td>/;
		print O "$1 priority=\"$2\" message=\"$3\"\n";
		};
	};

close(O);
move("$log.new", "$log") || die "Failed to move $log.new to $log - $!\n";
