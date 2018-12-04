#!/usr/bin/perl
#
# Program: lock_and_run.perl
# Author: Ken Barnhouse
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

local($lockfile,$command);

$lockfile = shift(@ARGV);
$command = join(' ',@ARGV);

#
# try to open the lockfile, it found, the command is already running so exit
#
if (open(LCK,$lockfile)) 
    {
	$pid = <LCK>;
	$DEBUG && printf "already running as pid %s\n",$pid;
	exit(0);
    }
else
   {
#
# else open the lockfile for write and write my PID to it
#
       open(LCK,">$lockfile") || die "can't open $lockfile for write";
       print LCK "$$";
   }

#
# run the command as a child of this process
#

system($command);

#
# once the command is done, close and remove the lockfile so the next run
# can start
#

close(LCK);
$DEBUG && exit(0);  # if running in DEBUG exit now to keep lockfile around
unlink($lockfile);
