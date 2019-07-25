#!/usr/local/bin/perl

print "Content-type: text/plain", "\n\n";

@hosts = ("haiku.camb.opengroup.org");

$count_file = "/usr/home/mena/public_html/newboston/bonita_count.txt";
$remote_host = "$ENV{'REMOTE_HOST'}";
$valid_host = 1;

if (open (FILE, "<" . $count_file)) {
    $no_accesses = <FILE>;
    close (FILE);

    if (open (FILE, ">" . $count_file)) {

        if (@hosts && $remote_host) {
            foreach $host (@hosts) {
                if ($remote_host =~ /$host/) {
                    $valid_host = 0;
                    last;
                } 
            }
        }

        if ($valid_host == 1) {
            $no_accesses++;
        }

        print FILE $no_accesses;
        close (FILE);
#       print $no_accesses;
    } else {
        print "[NACK!  Can't write to data file!]", "\n";
    }

} else {
    print "[NACK!  Can't read the data file!]", "\n";
}

exit (0);
