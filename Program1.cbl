       identification division.
       program-id. A4-SalaryReport.
       author. Kaifkhan Vakil.
       date-written. 2021-02-23.


       environment division.
       configuration section.

       input-output section.
       file-control.

           select input-file
           assign to "../../../A4.dat"
           organization is line sequential.

           select output-file 
           assign to "../../../A4-SalaryReport.out".

       data division.
       file section.

       fd input-file
           data record is input-line
           record contains 29 characters.

       01 input-line.
         05 il-employee-number     pic x(3).
         05 il-employee-name       pic x(15).
         05 il-education-code      pic x.
         05 il-service-years       pic 99.
         05 il-present-salary      pic 99999v99.

       fd output-file
           data record is output-line
           record contains 80 characters.

       01 output-line              pic x(80).


       working-storage section.

       01 ws-report-heading.
         05 filler                 pic x(28)    value 
         "Kaifkhan Vakil, Assignment 4".
         
       01 ws-report-heading1.
         05 filler                 pic x(30)   value spaces.
         05 filler                 pic x(22)   value 
         "EMPLOYEE SALARY REPORT".
         05 filler                 pic x(14)   value spaces.
         05 filler                 pic x(5)    value "Page:".
         05 ws-page-number         pic z9.

       01 ws-report-heading2.
         05 filler                 pic x       value spaces.
         05 filler                 pic x(3)    value "EMP".
         05 filler                 pic x(2)    value spaces.
         05 filler                 pic x(3)    value "EMP".
         05 filler                 pic x(28)   value spaces.
         05 filler                 pic x(7)    value "PRESENT".
         05 filler                 pic x(2)    value spaces.
         05 filler                 pic x(8)    value "INCREASE".
         05 filler                 pic x(5)    value spaces.
         05 filler                 pic x(3)    value "PAY".
         05 filler                 pic x(11)   value spaces.
         05 filler                 pic x(3)    value "NEW".

       02 ws-report-heading3.
         05 filler                 pic x value spaces.
         05 filler                 pic x(3) value "NUM".
         05 filler                 pic x(2) value spaces.
         05 filler                 pic x(4) value "NAME".
         05 filler                 pic x(10) value spaces.
         05 filler                 pic x(5)    value "YEARS".
         05 filler                 pic x   value spaces.
         05 filler                 pic x(8) value "POSITION".
         05 filler                 pic x(4)    value spaces.
         05 filler                 pic x(6) value "SALARY".
         05 filler                 pic x(5) value spaces.
         05 filler                 pic x value "%".
         05 filler                 pic x(7) value spaces.
         05 filler                 pic x(8) value "INCREASE".
         05 filler                 pic x(7) value spaces.
         05 filler                 pic x(6) value "SALARY".

       01 ws-detail-line.
         05 filler                 pic x value spaces.
         05 ws-employee-number     pic x(3).
         05 filler                 pic x value spaces.
         05 ws-employee-name       pic x(15).
         05 filler                 pic x(2) value spaces.
         05 ws-employee-years      pic z9.
         05 filler                 pic x(2) value spaces.
         05 ws-employee-position   pic x(8) .
         05 filler                 pic x(2) value spaces.
         05 ws-present-salary      pic zz,zz9.99 value 0.
         05 filler                 pic x(2) value spaces.
         05 ws-increase-percentage pic z9.9.
         05 ws-sign                 pic x value "%".
         05 filler                 pic x(3) value spaces.
         05 ws-increase-pay        pic $$$,$$9.99+.
         05 filler                 pic x value spaces.
         05 ws-dollar-sign         pic x .
         05 filler                 pic x(2) value spaces.
         05 ws-new-salary          pic zzz,zz9.99.

       01 ws-subtotal-line1.
         05 filler                 pic x(16) value " EMPLOYEE CLASS:".
         05 filler                 pic x(8) value spaces.
         05 filler                 pic x(7) value "Analyst".
         05 filler                 pic x(4) value spaces.
         05 filler                 pic x(8) value "Sen Prog".
         05 filler                 pic x(4) value spaces.
         05 filler                 pic x(4) value "Prog".
         05 filler                 pic x(4) value spaces.
         05 filler                 pic x(7) value "Jr Prog".
         05 filler                 pic x(4) value spaces.
         05 filler                 pic x(12) value "Unclassified".

       01 ws-sutotal-line2.
         05 filler                 pic x(16) value " # ON THIS PAGE:".
         05 filler                 pic x(13) value spaces.
         05 ws-analyst-count       pic z9.
         05 filler                 pic x(10) value spaces.
         05 ws-sen-prog-count      pic z9.
         05 filler                 pic x(6) value spaces.
         05 ws-prog-count          pic z9.
         05 filler                 pic x(9) value spaces.
         05 ws-jr-prog-count       pic z9.
         05 filler                 pic x(14) value spaces.
         05 ws-unclassified-count  pic z9.

       01 ws-total-line1.
         05 filler                 pic x(19) value 
         " AVERAGE INCREASES:".
         05 filler                 pic x(3) value spaces.
         05 filler                 pic x(8) value "ANALYST=".
         05 filler                 pic x(5) value spaces.
         05 ws-analyst-average     pic z,zz9.99.
         05 filler                 pic x(5) value spaces.
         05 filler                 pic x(9) value "SEN PROG=".
         05 filler                 pic x(3) value spaces.
         05 ws-sen-prog-average    pic z,zz9.99.

       01 ws-total-line2.
         05 filler                 pic x(22) value spaces.
         05 filler                 pic x(5) value "PROG=".
         05 filler                 pic x(8) value spaces.
         05 ws-prog-average        pic z,zz9.99.
         05 filler                 pic x(5) value spaces.
         05 filler                 pic x(8) value "JR PROG=".
         05 filler                 pic x(4) value spaces.
         05 ws-jr-prog-average     pic z,zz9.99.

       01 ws-cnsts.
         05 ws-analyst-position    pic x(7) value "ANALYST".
         05 ws-prog-position       pic x(7) value "PROG".
         05 ws-sen-prog-position   pic x(8) value "SEN PROG".
         05 ws-jr-prog-position    pic x(8) value "JR PROG".
         05 ws-position-contnt     pic x(8).
         05 ws-analyst-percentage  pic 99v9 value 12.8.
         05 ws-sen-prog-percentage pic 99v9 value 9.3.
         05 ws-prog-percentage     pic 99v9 value 6.7.
         05 ws-jr-prog-percentage  pic 99v9 value 3.2.
         05 ws-percent-holder      pic 99v9.
         05 ws-percent-sign        pic x    value "%".
         05 ws-dollar-sign-cont    pic x value "$".

       01 ws-calcs.
         05 ws-pay-increase        pic 9(5)v99. 
         05 ws-new-salary-calc          pic 9(7)v99.
         05 ws-12-half-percent          pic 99v999 value 0.128.
         05 ws-9-half-percent           pic 99v999 value 0.093.
         05 ws-6-half-percent      pic 99v999 value 0.067.
         05 ws-3-half-percent      pic 99v999 value 0.032.

       01 ws-counters.
         05 ws-analyst-counter       pic 99 value 0.
         05 ws-sen-prog-counter      pic 99 value 0.
         05 ws-prog-counter          pic 99 value 0.
         05 ws-jr-prog-counter       pic 99 value 0.
         05 ws-unclaissified-counter pic 99 value 0.
        
       01 ws-flags.
         05 ws-eof-flag            pic x   value "n".
         05 ws-other-flag          pic x   value "x".

       77 ws-lines-per-page        pic 99 value 10.
       77 ws-page-count            pic 99 value 0.
       77 ws-line-count            pic 99 value 0.
       77 ws-file-empty            pic x value "e".
       77 ws-file-opened           pic x value "o".
       77 ws-zero                  pic 9 value 0.
       77 ws-one                   pic 9 value 1.
       77 ws-two                   pic 9 value 2.





       procedure division.

           open input input-file.
           open output output-file.
           move ws-file-opened to ws-eof-flag.

           write output-line from ws-report-heading
           after advancing ws-one line.

           read input-file
           at end
           move ws-file-empty to ws-eof-flag.

           perform 400-process-pages
           until ws-eof-flag equals   ws-file-empty.



           close output-file, input-file.
           goback.

       400-process-pages.
           add ws-one to ws-page-count.
           move ws-page-count to ws-page-number.

           if(ws-page-count > ws-one) then 
               write output-line from ws-report-heading1
               after advancing page
           else 
               write output-line from ws-report-heading1
           end-if.
           write output-line from ws-report-heading2
           after advancing ws-two lines.
           write output-line from ws-report-heading3.
           perform 450-process-lines
           varying ws-line-count from ws-one by ws-one 
           until (ws-line-count > ws-lines-per-page
           OR ws-eof-flag = ws-file-empty).
           
           move ws-analyst-counter to ws-analyst-count.
           move ws-sen-prog-counter to ws-sen-prog-count.
           move ws-prog-counter to ws-prog-count.
           move ws-jr-prog-counter to ws-jr-prog-count.
           move ws-unclaissified-counter to ws-unclassified-count.
           write output-line from ws-subtotal-line1 
           after advancing 1 line.
           write output-line from ws-sutotal-line2
           before advancing 2 lines.
           move 0 to ws-analyst-counter.
           move 0 to ws-sen-prog-counter.
           move 0 to ws-prog-counter.
           move 0 to ws-jr-prog-counter.
           move 0 to ws-unclaissified-counter.

       450-process-lines.
           move 0 to ws-percent-holder.
           move 0 to ws-pay-increase
           move 0 to ws-new-salary-calc.
           if(il-education-code equals "G") then 
             if(il-service-years > 15) then 
                move ws-analyst-position to ws-position-contnt
                move ws-analyst-percentage to ws-percent-holder
                compute ws-pay-increase rounded = il-present-salary * 
                ws-12-half-percent
                compute ws-new-salary-calc rounded = ws-pay-increase + 
                il-present-salary
                add 1 to ws-analyst-counter 
             else
                if((il-service-years>=7) and (il-service-years <=15))
                     then
                  move ws-sen-prog-position to ws-position-contnt
                  move ws-sen-prog-percentage to ws-percent-holder
                  compute ws-pay-increase rounded =il-present-salary *
                         ws-9-half-percent
                       compute ws-new-salary-calc rounded =
                         ws-pay-increase +
                         il-present-salary
                       add 1 to ws-sen-prog-counter
                else 
                   if ((il-service-years<7) and (il-service-years>2))
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
                   else move spaces to ws-position-contnt
           move 0 to ws-pay-increase
           add 1 to ws-unclaissified-counter
                           compute ws-new-salary-calc rounded =
                             ws-pay-increase +
                             il-present-salary
                       end-if
                   end-if
               end-if
           end-if.

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

               else
                   if ((il-service-years<=10) and (il-service-years>4)) 
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
                   else
                       if (il-service-years <=4 ) then
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

           move spaces to ws-detail-line.
           move il-employee-number to ws-employee-number.
           move il-employee-name to ws-employee-name.
           move il-service-years to ws-employee-years.
           move il-present-salary to ws-present-salary.
          move ws-position-contnt to ws-employee-position.
            move ws-percent-sign to ws-sign.
           move ws-percent-holder to ws-increase-percentage.
           move ws-pay-increase to ws-increase-pay.
           move ws-new-salary-calc to ws-new-salary.
          move ws-dollar-sign-cont to ws-dollar-sign.
           write output-line from ws-detail-line 


           before advancing ws-two lines.

           read input-file
               at end
                   move ws-file-empty to ws-eof-flag.

       end program A4-SalaryReport.