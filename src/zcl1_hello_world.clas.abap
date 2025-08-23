CLASS zcl1_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl1_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "out->write( 'Hello World!' ).
    "out->write( 'Hello World!' ).
    "out->write( 'Hello World!' ).
    "out->write( 'Hello World!' ).
    out->write( 'Hello World! ' ).
    data  user_name type string value 'Linda'.
    out->write( user_name ).
  ENDMETHOD.
ENDCLASS.
