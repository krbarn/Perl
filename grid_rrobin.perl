#!/usr/bin/perl
#
# Program: grid_rrobin.perl
# Author: Ken Barnhouse
# Date: 10-11-2002
# Usage: lock_and_run.perl lockfilename command
# Purpose: to check a lock file to see if another instance of command is
#          running.  If not, it write a lock file out and start command
#          running.  When command exists, the lock file is removed.
#          This is good for cron jobs to make sure that only one copy
#          of command is running at a time
#
#

$DEBUG = 0;

#
# Get parameters
#

local($command);

#
# run the command as a child of this process
#

system($command);

open(HFILE, "mpd.hosts");
@hosts = (<HFILE>);
close(HFILE);

foreach $ihost (@hosts) {
	chomp($ihost);
	print "ssh $ihost $command\n";
#	system("ssh $ihost $command");
}
