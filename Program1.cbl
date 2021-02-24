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
         05 il-employee-name       pic x(14).
         05 il-education-code      pic x.
         05 il-service-years       pic z9.
         05 il-present-salary      pic zzzz9.99.

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
         05 ws-employee-number     pic x(3).
         05 filler                 


       procedure division.

           goback.

       end program A4-SalaryReport.