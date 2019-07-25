#!/usr/local/bin/perl
 
print "Content-type: text/html", "\n\n";

use English                 ; # Understand English i.e. && = and

#
# initialize variables
#

$InputFile = "/pages/n/newboston.net/harpers/log.html";

$log_page = "/pages/n/newboston.net/harpers/log_summary.html";

chop ( $TodaysDate = `date '+%m/%d/%y'` ) ;   # Get Today's date
$MonthIndex = -1 ;                            # Initialize array index
$GrandTotal = 0 ;                             # Initialize grand total
$ThisMonth = 0 ;                              # Initialize month flag

# Open the data and log files

open ( MSG, "$InputFile" ) or die "Cannot open the message file.\n" ;
open ( OUT, ">$log_page" ) or die "Cannot open the output file.\n" ;
 
# Blast throught the file 
 
while ( chop ( $Line = <MSG> ) )
{

   next if not $Line =~ /on/ ; # Skip anything that isn't a log entry

   @Items = ( )                   ; # empty the array
   @Items = split ( ' ', $Line )  ; # Break the line into pieces

   $LogHost    = $Items[0]        ; # the logging host
   $LogDate    = $Items[2]        ; # the log date
   $LogTime    = $Items[4]        ; # the time of the log entry

   ($Month,$Day,$Year) = split (/\//,  $LogDate )  ; # break up date

# Gather Totals on a monthly basis

   if ( $Month != $ThisMonth ) 
   { 
      $MonthIndex ++ ;                        # increment month index
      $MonthlyMonth{$MonthIndex} = "$Month/$Year" ;
   }

   $MonthlyTotal{$MonthIndex} ++            ; # increment monthly total
   $GrandTotal ++                           ; # increment grand total
   $ThisMonth = $Month                      ; # save this month

}

#
# print to the log page
#

print OUT "<html>";
print OUT "  <head>";
print OUT "    <title>Guest Log Summary by Month</title>";
print OUT "  </head>";
print OUT "  <body bgcolor=#FFFFFF>";
print OUT "    <center>";
print OUT "      <h1>Guest Log Summary by Month</h1>";
print OUT "    </center>";
print OUT "";
print OUT "    <hr>";
print OUT "";
print OUT "  </body>";
print OUT "</html>";
print OUT "";
print OUT "<BR>";

for ( $i = 0; $i <= $MonthIndex; $i ++ )
{

   print OUT "$MonthlyMonth{$i} $MonthlyTotal{$i} <BR>";
}

print OUT "<BR>Total  $GrandTotal<BR>";

close ( MSG ) ;
close ( OUT ) ;

exit (0);
