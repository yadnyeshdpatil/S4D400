CLASS lhc_zr_1flight_2108 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Flight
        RESULT result,
      validatePrice FOR VALIDATE ON SAVE
        IMPORTING keys FOR Flight~validatePrice.
ENDCLASS.

CLASS lhc_zr_1flight_2108 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD validatePrice.
    DATA failed_record LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    READ ENTITIES OF zr_1flight_2108 IN LOCAL MODE
        ENTITY flight
        FIELDS ( price )
        WITH CORRESPONDING #( keys )
        RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).

      IF flight-price <= 0.
        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-flight.
        reported_record-%tky = flight-%tky.
        reported_record-%msg =
            new_message(
            id = '/LRN/S4D400'
            number = '101'
            severity = if_abap_behv_message=>severity-error
            ).
        APPEND reported_record TO reported-flight.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
