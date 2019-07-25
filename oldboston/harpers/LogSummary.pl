#!/usr/local/bin/perl
 
use English                 ; # Understand English i.e. && = and

# Main #

chop ( $TodaysDate = `date '+%m/%d/%y'` ) ;   # Get Today's date
$MonthIndex = -1 ;                            # Initialize array index
$GrandTotal = 0 ;                             # Initialize grand total
$ThisMonth = 0 ;                              # Initialize month flag

$InputFile = "log.html";

$OutFile  = "log_summary.out" ; 

# Open the data and log files

open ( MSG, "$InputFile" ) or die "Cannot open the message file.\n" ;
open ( OUT, ">$OutFile" ) or die "Cannot open the output file.\n" ;
 
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

for ( $i = 0; $i <= $MonthIndex; $i ++ )
{
   print "$MonthlyMonth{$i} $MonthlyTotal{$i}\n";
}

print "\nTotal $GrandTotal\n";

close ( MSG ) ;
close ( OUT ) ;

# This output formats

format OUT_TOP =
                          REPORT for @<<<<<<<<
			   	  $TodaysDate


Month and Year              Total Hits
--------------------------------------
.

format OUT =
@<<<<<<<<<<<<<<<<<<<<           @##                     @####
$Month,$Year,$MonthlyTotal{$Month}
.

format OUT_SUMMARY =
                                                       ---------
Total Hits                                              @####
                                $GrandTotal

.

