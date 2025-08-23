CLASS z_getcertifiedsession3_2408 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_getcertifiedsession3_2408 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_source,
             id   TYPE i,
             name TYPE string,
             age  TYPE i,
             city TYPE string,
           END OF ty_source.

    TYPES: BEGIN OF ty_target,
             id      TYPE i,
             name    TYPE string,
             age     TYPE i,
             country TYPE string,
           END OF ty_target.
*1.
* Move corresponding
*● The fields must have identical names.
*● The components do not have to be in the same position or sequence in the two structures.
*● If the fields have different types, ABAP attempts a type conversion according to the
*predefined set of rules.
*Declare and populate source structure
    DATA: ls_source TYPE ty_source,
          ls_target TYPE ty_target.

    ls_source-id = 1.
    ls_source-name = 'John Doe' ##NO_TEXT.
    ls_source-age = 30.
    ls_source-city = 'New York'.

* Use MOVE-CORRESPONDING with # keyword
    ls_target = CORRESPONDING #( ls_source ).

* Output results using out->write
    out->write( |1:******************| ).
    out->write( |Source Structure:| ).
    out->write( |ID: { ls_source-id }| ).
    out->write( |Name: { ls_source-name }| ).
    out->write( |Age: { ls_source-age }| ).
    out->write( |City: { ls_source-city }| ).
    out->write( || ).
    out->write( |Target Structure after MOVE-CORRESPONDING:| ).
    out->write( |ID: { ls_target-id }| ).
    out->write( |Name: { ls_target-name }| ).
    out->write( |Age: { ls_target-age }| ).
    out->write( |Country: { ls_target-country }| ).

*2.
*SELECT INTO STRUCTURE
    TYPES: BEGIN OF ty_connection,
             carrid           TYPE c LENGTH 3,
             connid           TYPE numc5,
             DepartureAirport TYPE c LENGTH 3,
             Distance         TYPE int4,
           END OF ty_connection.

    DATA: ls_connection TYPE ty_connection.

*The INTO clause of the SELECT statement will only work correctly if the number and types of
*the components of the structure correspond to the number and types of the columns
*specified in the FIELDS clause.The following statement can only work if the
*target structure connection has three components with the same type and length as the
*columns listed in the FIELDS clause.
*Note that, in this case, the names do not have to be identical - the system fills the
*target structure from left to right.

    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS AirlineID,ConnectionID,DepartureAirport
    WHERE AirlineID = 'AA'
    INTO @ls_connection.

    out->write( |2:******************| ).
    out->write( ls_connection ).

*Using into corresponding.
    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS AirlineID AS carrid, ConnectionID AS connid, DepartureAirport,Distance
    WHERE AirlineID = 'AA'
    INTO CORRESPONDING FIELDS OF @ls_connection. "Names should be the same for into corresponding to work. And data loss will occur if the types are different or runtime errors.

    out->write( |2:******************| ).
    out->write( ls_connection ).
*3.
*Local Class visibility,
*These types are local to the program or include and cannot be accessed outside unless explicitly passed or exposed.
*In a class, they are not part of the class’s public interface unless referenced in public methods or attributes.
*The type ty_testvisibility is defined in the local types tab.
    DATA: ls_visibility_structure TYPE ty_testvisibilitystructure-visibility VALUE 'STRUCTURE IS Visible',
          lv_visibility_variable  TYPE ty_visibilityvariable VALUE ' VARIABLE IS Visible'.

    out->write( |3:******************| ).
    out->write( ls_visibility_structure ).
    out->write( lv_visibility_variable ).

  ENDMETHOD.
ENDCLASS.
