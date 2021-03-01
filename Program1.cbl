       identification division.
       program-id. A4-SalaryReport.
       author. Kaifkhan Vakil.
       date-written. 2021-02-23.
      *Program description: 
      *In the following program we will be calculating salary report of 
      *the employees which are either graduates or non graduates and 
      *they have been assigned different postion according to the years
      *they  have worked in the company. We are reading input from a
      *.dat file and outputting it in the .out file. 

       environment division.
       configuration section.

       input-output section.
       file-control.
      *Defining input and output of the file and the file position they
      *will be writing from. 
           select input-file
           assign to "../../../A4.dat"
           organization is line sequential.

           select output-file 
           assign to "../../../A4-SalaryReport.out".

       data division.
       file section.
      *This is the file section where we would be difining line 
      *variables from where we will be reading and in which we will be 
      *writing the data.

      *Input definition
       fd input-file
           data record is input-line
           record contains 29 characters.

       01 input-line.
         05 il-employee-number         pic x(3).
         05 il-employee-name           pic x(15).
         05 il-education-code          pic x.
         05 il-service-years           pic 99.
         05 il-present-salary          pic 99999v99.


      *Output definition
       fd output-file
           data record is output-line
           record contains 80 characters.

       01 output-line                  pic x(80).


       working-storage section.
      *This section will be showing the report heading at the top of the
      *report. SHowing my name and the date it was created.
       01 ws-report-heading.
         05 filler                     pic x(28)   value 
         "Kaifkhan Vakil, Assignment 4".
         05 filler                     pic x(15)   value spaces.
         05 filler                     pic x(8)    value "20210411".
         05 filler                     pic x(23)   value spaces.
         05 filler                     pic x(7)    value "1951043".
         
      *  This is second line of report heading which will be showing 
      *  heading at the start of each page which also shows the number.
       01 ws-report-heading1.
         05 filler                     pic x(30)   value spaces.
         05 filler                     pic x(22)   value 
         "EMPLOYEE SALARY REPORT".
         05 filler                     pic x(14)   value spaces.
         05 filler                     pic x(5)    value "Page:".
         05 ws-page-number             pic z9.

      *This is the section showing column headings on the page.
       01 ws-report-heading2.
         05 filler                     pic x       value spaces.
         05 filler                     pic x(3)    value "EMP".
         05 filler                     pic x(2)    value spaces.
         05 filler                     pic x(3)    value "EMP".
         05 filler                     pic x(28)   value spaces.
         05 filler                     pic x(7)    value "PRESENT".
         05 filler                     pic x(2)    value spaces.
         05 filler                     pic x(8)    value "INCREASE".
         05 filler                     pic x(5)    value spaces.
         05 filler                     pic x(3)    value "PAY".
         05 filler                     pic x(11)   value spaces.
         05 filler                     pic x(3)    value "NEW".

      *This is the second section showing columns headings.
       02 ws-report-heading3.
         05 filler                     pic x       value spaces.
         05 filler                     pic x(3)    value "NUM".
         05 filler                     pic x(2)    value spaces.
         05 filler                     pic x(4)    value "NAME".
         05 filler                     pic x(10)   value spaces.
         05 filler                     pic x(5)    value "YEARS".
         05 filler                     pic x       value spaces.
         05 filler                     pic x(8)    value "POSITION".
         05 filler                     pic x(4)    value spaces.
         05 filler                     pic x(6)    value "SALARY".
         05 filler                     pic x(5)    value spaces.
         05 filler                     pic x       value "%".
         05 filler                     pic x(7)    value spaces.
         05 filler                     pic x(8)    value "INCREASE".
         05 filler                     pic x(7)    value spaces.
         05 filler                     pic x(6)    value "SALARY".

      *  In this section i have defined detail line variable which will
      *be showing content of the file after reading from the input file.
       01 ws-detail-line.
         05 filler                     pic x       value spaces.
         05 ws-employee-number         pic x(3).
         05 filler                     pic x       value spaces.
         05 ws-employee-name           pic x(15).
         05 filler                     pic x(2)    value spaces.
         05 ws-employee-years          pic z9.
         05 filler                     pic x(2)    value spaces.
         05 ws-employee-position       pic x(8) .
         05 filler                     pic x(2)    value spaces.
         05 ws-present-salary          pic zz,zz9.99
                                                   value 0.
         05 filler                     pic x(2)    value spaces.
         05 ws-increase-percentage     pic z9.9.
         05 ws-sign                    pic x       value "%".
         05 filler                     pic x(3)    value spaces.
         05 ws-increase-pay            pic $$$,$$9.99+.
         05 filler                     pic x       value spaces.
         05 ws-dollar-sign             pic x .
         05 filler                     pic x(2)    value spaces.
         05 ws-new-salary              pic zzz,zz9.99.

      *This section will show first line of subtotal area at the end of
      *each page showing numbr of employees with individual 
      *classification.
       01 ws-subtotal-line1.
         05 filler                     pic x(16)   value 
         " EMPLOYEE CLASS:".
         05 filler                     pic x(8)    value spaces.
         05 filler                     pic x(7)    value "Analyst".
         05 filler                     pic x(4)    value spaces.
         05 filler                     pic x(8)    value "Sen Prog".
         05 filler                     pic x(4)    value spaces.
         05 filler                     pic x(4)    value "Prog".
         05 filler                     pic x(4)    value spaces.
         05 filler                     pic x(7)    value "Jr Prog".
         05 filler                     pic x(4)    value spaces.
         05 filler                     pic x(12)   value "Unclassified".

      *This is the second subtotal line.
       01 ws-sutotal-line2.
         05 filler                     pic x(16)   value 
         " # ON THIS PAGE:".
         05 filler                     pic x(13)   value spaces.
         05 ws-analyst-count           pic z9.
         05 filler                     pic x(10)   value spaces.
         05 ws-sen-prog-count          pic z9.
         05 filler                     pic x(6)    value spaces.
         05 ws-prog-count              pic z9.
         05 filler                     pic x(9)    value spaces.
         05 ws-jr-prog-count           pic z9.
         05 filler                     pic x(14)   value spaces.
         05 ws-unclassified-count  pic z9.

      *This is teh total line which will be shown at the end of report 
      *consisting of the average increases of classification.
       01 ws-total-line1.
         05 filler                     pic x(19)   value 
         " AVERAGE INCREASES:".
         05 filler                     pic x(3)    value spaces.
         05 filler                     pic x(8)    value "ANALYST=".
         05 filler                     pic x(5)    value spaces.
         05 ws-analyst-average         pic z,zz9.99.
         05 filler                     pic x(5)    value spaces.
         05 filler                     pic x(9)    value "SEN PROG=".
         05 filler                     pic x(3)    value spaces.
         05 ws-sen-prog-average        pic z,zz9.99.

      *This is the second line of total line.
       01 ws-total-line2.
         05 filler                     pic x(22)   value spaces.
         05 filler                     pic x(5)    value "PROG=".
         05 filler                     pic x(8)    value spaces.
         05 ws-prog-average            pic z,zz9.99.
         05 filler                     pic x(5)    value spaces.
         05 filler                     pic x(8)    value "JR PROG=".
         05 filler                     pic x(4)    value spaces.
         05 ws-jr-prog-average         pic z,zz9.99.

      *  This section is solely for the calculation purpose, variable 
      *  which i will be using later in my calculation
       01 ws-calcs.
         05 ws-pay-increase            pic 9(5)v99. 
         05 ws-new-salary-calc         pic 9(7)v99.
         05 ws-12-half-percent         pic 99v999  value 0.128.
         05 ws-9-half-percent          pic 99v999  value 0.093.
         05 ws-6-half-percent          pic 99v999  value 0.067.
         05 ws-3-half-percent          pic 99v999  value 0.032.
       
      *This is the section which will be holding all the counters used 
      *later in the calculation.
       01 ws-counters.
         05 ws-analyst-counter         pic 99      value 0.
         05 ws-sen-prog-counter        pic 99      value 0.
         05 ws-prog-counter            pic 99      value 0.
         05 ws-jr-prog-counter         pic 99      value 0.
         05 ws-unclaissified-counter   pic 99      value 0.
         05 ws-analyst-rep-counter     pic 99      value 0.
         05 ws-sen-prog-rep-counter    pic 99      value 0.
         05 ws-prog-rep-counter        pic 99      value 0.
         05 ws-jr-prog-rep-counter     pic 99      value 0.
         05 ws-pay-analyst             pic 9(7)v99 value 0.
         05 ws-pay-sen-prog            pic 9(7)v99 value 0.
         05 ws-pay-prog                pic 9(7)v99 value 0.
         05 ws-jr-prog                 pic 9(7)v99 value 0.
         05 ws-interim-analyst         pic 9(7)v99 value 0.
         05 ws-interim-sen-prog        pic 9(7)v99 value 0.
         05 ws-interim-prog            pic 9(7)v99 value 0.
         05 ws-interim-jr-prog         pic 9(7)v99 value 0.

      *This is the flag section which will be keeping the record of the 
      *  end of line of the file
       01 ws-flags.
         05 ws-eof-flag                pic x       value "n".
         05 ws-other-flag              pic x       value "x".

      *These are all the constants which we will be using in the 
      *calculation.
       77 ws-lines-per-page            pic 99      value 10.
       77 ws-page-count                pic 99      value 0.
       77 ws-line-count                pic 99      value 0.
       77 ws-file-empty                pic x       value "e".
       77 ws-file-opened               pic x       value "o".
       77 ws-zero                      pic 9       value 0.
       77 ws-one                       pic 9       value 1.
       77 ws-two                       pic 9       value 2.
       77 ws-analyst-position          pic x(7)    value "ANALYST".
       77 ws-prog-position             pic x(7)    value "PROG".
       77 ws-sen-prog-position         pic x(8)    value "SEN PROG".
       77 ws-jr-prog-position          pic x(8)    value "JR PROG".
       77 ws-position-contnt           pic x(8).
       77 ws-analyst-percentage        pic 99v9    value 12.8.
       77 ws-sen-prog-percentage       pic 99v9    value 9.3.
       77 ws-prog-percentage           pic 99v9    value 6.7.
       77 ws-jr-prog-percentage        pic 99v9    value 3.2.
       77 ws-percent-holder            pic 99v9.
       77 ws-percent-sign              pic x value "%".
       77 ws-dollar-sign-cont          pic x value "$".


       procedure division.

      *    Open files
           perform 010-open-files.
           move ws-file-opened         to ws-eof-flag.
      *    Writing report headings
           perform 020-write-report-heading.
      *    Read input from the file
           perform 030-read-input.
      *    Prcessing pages which will be showing data, subtotal and 
      *    total lines
           perform 400-process-pages
           until ws-eof-flag equals   ws-file-empty.
      *    Displaying total line at the end of the report after all the
      *    data is been processed
           perform 500-write-total-line.
           perform 600-close-file.
          
           goback.

      *This section takes care of printing subotoal line and data in the
      *output file
       400-process-pages.
           add ws-one                  to ws-page-count.
           move ws-page-count          to ws-page-number.
           perform 410-process-headings.
           perform 450-process-lines
           varying ws-line-count       from ws-one by ws-one 
           until (ws-line-count > ws-lines-per-page
           OR ws-eof-flag = ws-file-empty).
           perform 490-write-subtotal-line.
          

      *    This section displays headings at the top of the report and 
      *    column headings too
       410-process-headings.
           if (ws-page-count > ws-one) then
               write output-line       from ws-report-heading1
                 after advancing page
           else
               write output-line       from ws-report-heading1
           end-if.
           write output-line           from ws-report-heading2
             after advancing ws-two lines.
           write output-line           from ws-report-heading3
             before advancing ws-two lines.

       
      *This section is procesing each line from the input file and 
      *    making new columns for displaying them.
       450-process-lines.
           move 0                      to ws-percent-holder.
           move 0                      to ws-pay-increase
           move 0                      to ws-new-salary-calc.
           perform 460-process-graduates.
           perform 470-process-non-graduates.
           perform 480-write-detail-line.
           perform 030-read-input.

      *This section takes are of all teh calculation that under goes 
      *while the record is of a graduate.
       460-process-graduates.
           if (il-education-code equals "G") then
               if (il-service-years > 15) then
                   move ws-analyst-position to ws-position-contnt
                   move ws-analyst-percentage to ws-percent-holder
                   compute ws-pay-increase rounded = il-present-salary *
                     ws-12-half-percent
                   compute ws-new-salary-calc rounded = ws-pay-increase
                     +
                     il-present-salary
                   add 1 to ws-analyst-counter
                   add 1 to ws-analyst-rep-counter
                   add ws-pay-increase to ws-pay-analyst
               else
                   if ((il-service-years >= 7) and (il-service-years <=
                     15))
                     then
                       move ws-sen-prog-position to ws-position-contnt
                       move ws-sen-prog-percentage to ws-percent-holder
                       compute ws-pay-increase rounded =
                         il-present-salary *
                         ws-9-half-percent
                       compute ws-new-salary-calc rounded =
                         ws-pay-increase +
                         il-present-salary
                       add 1 to ws-sen-prog-counter
                       add 1 to ws-sen-prog-rep-counter
                       add ws-pay-increase to ws-pay-sen-prog
                   else
                       if ((il-service-years < 7) and (il-service-years
                         > 2))
                         then
                           move ws-prog-position to ws-position-contnt
                           move ws-prog-percentage to ws-percent-holder
                           compute ws-pay-increase rounded =
                             il-present-salary *
                             ws-6-half-percent
                           compute ws-new-salary-calc rounded =
                             ws-pay-increase +
                             il-present-salary
                           add 1 to ws-prog-counter
                           add 1 to ws-prog-rep-counter
                           add ws-pay-increase to ws-pay-prog
                       else
                           move spaces to ws-position-contnt
                           move 0 to ws-pay-increase
                           add 1 to ws-unclaissified-counter
                           compute ws-new-salary-calc rounded =
                             ws-pay-increase +
                             il-present-salary
                       end-if
                   end-if
               end-if
           end-if.

      *This section takes care of the calcualtion that happens when the 
      *    record is for a non graduate.
       470-process-non-graduates.
           if (il-education-code equals "N") then
               if (il-service-years > 10) then
                   move ws-prog-position to ws-position-contnt
                   move ws-prog-percentage to ws-percent-holder
                   compute ws-pay-increase rounded = il-present-salary *
                     ws-6-half-percent
                   compute ws-new-salary-calc rounded = ws-pay-increase
                     +
                     il-present-salary
                   add 1 to ws-prog-counter
                   add 1 to ws-prog-rep-counter
                   add ws-pay-increase to ws-pay-prog

               else
                   if ((il-service-years <= 10) and (il-service-years >
                     4))
                     then
                       move ws-jr-prog-position to ws-position-contnt
                       move ws-jr-prog-percentage to
                         ws-percent-holder
                       compute ws-pay-increase rounded =
                         il-present-salary *
                         ws-3-half-percent
                       compute ws-new-salary-calc rounded =
                         ws-pay-increase +
                         il-present-salary
                       add 1 to ws-jr-prog-counter
                       add 1 to ws-jr-prog-rep-counter
                       add ws-pay-increase to ws-jr-prog
                   else
                       if (il-service-years <= 4) then
                           move spaces to ws-position-contnt
                           move 0 to ws-pay-increase
                           compute ws-new-salary-calc rounded =
                             ws-pay-increase +
                             il-present-salary
                           add 1 to ws-unclaissified-counter
                       end-if
                   end-if
               end-if
           end-if.

      *    This section displays detail output for the final report
       480-write-detail-line.
           move spaces to ws-detail-line.
           move il-employee-number     to ws-employee-number.
           move il-employee-name       to ws-employee-name.
           move il-service-years       to ws-employee-years.
           move il-present-salary      to ws-present-salary.
           move ws-position-contnt     to ws-employee-position.
           move ws-percent-sign        to ws-sign.
           move ws-percent-holder      to ws-increase-percentage.
           move ws-pay-increase        to ws-increase-pay.
           move ws-new-salary-calc     to ws-new-salary.
           move ws-dollar-sign-cont    to ws-dollar-sign.
           write output-line           from ws-detail-line
             before advancing ws-one line.

      *This section takes care of the subtotal line 
       490-write-subtotal-line.
           move ws-analyst-counter     to ws-analyst-count.
           move ws-sen-prog-counter    to ws-sen-prog-count.
           move ws-prog-counter        to ws-prog-count.
           move ws-jr-prog-counter     to ws-jr-prog-count.
           move ws-unclaissified-counter
                                       to ws-unclassified-count.
           write output-line           from ws-subtotal-line1
             after advancing ws-one line.
           write output-line from ws-sutotal-line2
             before advancing ws-two lines.
           move 0                      to ws-analyst-counter.
           move 0                      to ws-sen-prog-counter.
           move 0                      to ws-prog-counter.
           move 0                      to ws-jr-prog-counter.
           move 0                      to ws-unclaissified-counter.

      *Open files
       010-open-files.
           open input input-file.
           open output output-file.

      *Write report heading
       020-write-report-heading.
           write output-line           from ws-report-heading
           before advancing ws-two lines.

      *Read input from the file
       030-read-input.
           read input-file
               at end
                   move ws-file-empty  to ws-eof-flag.

      *Write total line at the end of the report.
       500-write-total-line.
           compute ws-interim-analyst rounded = ws-pay-analyst /
             ws-analyst-rep-counter.
           compute ws-interim-sen-prog rounded = ws-pay-sen-prog /
             ws-sen-prog-rep-counter.
           compute ws-interim-prog rounded = ws-pay-prog /
             ws-prog-rep-counter.
           compute ws-interim-jr-prog rounded = ws-jr-prog /
             ws-jr-prog-rep-counter.

           move ws-interim-analyst     to ws-analyst-average.
           move ws-interim-sen-prog    to ws-sen-prog-average.
           move ws-interim-prog        to ws-prog-average.
           move ws-interim-jr-prog     to ws-jr-prog-average.

           write output-line           from ws-total-line1
             after advancing ws-one line.
           write output-line           from ws-total-line2.
       
      *Close files
       600-close-file.
           close output-file, input-file.

       end program A4-SalaryReport.