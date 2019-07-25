#!/usr/local/bin/perl

print "Content-type: text/html", "\n\n";

#
# initialize variables
#

@hosts = ("haiku.camb.opengroup.org");
$log_page = "/pages/n/newboston.net/harpers/log.html";
$valid_host = 1;

#
# environment variables to be logged
#

$remote_host = "$ENV{'REMOTE_HOST'}";
$referer = "$ENV{'HTTP_REFERER'}";
$date = `/bin/date +%m/%d/%y`;
$time = `/bin/date +%H:%M`;

#
# check to see if host is in exceptions list
#

if (@hosts && $remote_host) {
    foreach $host (@hosts) {
        if ($remote_host =~ /$host/) {
            $valid_host = 0;
            last;
        }
    }
}

#
# print to the calling page
#

if ($valid_host == 1) {

#   print "remote host $remote_host\n";
#   print " on $date at $time\n";

#
# print to the log page
#

    if (open(LOG, ">>" . $log_page)) {
	if ($referer) {
            print LOG "$remote_host from $referer on $date at $time", "<BR>";
	} else {
            print LOG "$remote_host on $date at $time", "<BR>";
	}
        close (LOG);
    } else {
        print "[NACK!  Could not open log file!", "\n";
    }

}

exit (0);

