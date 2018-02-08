*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*

METHOD example_02.
  TYPES:
    " Structure of document
    BEGIN OF ts_root,
      footer   TYPE string,
      header   TYPE string,
      t        TYPE tyt_rand_data,
      date     TYPE d,      " 8
      time     TYPE t,      " 6
      datetime TYPE char14, " date(8) + time(6)
    END OF ts_root.

  DATA:
    lo_file TYPE REF TO zif_xtt_file,
    ls_root TYPE ts_root.

  " No need to fill for empty template
  IF p_temp <> abap_true.
    ls_root-footer = 'Footer'.
    ls_root-header = 'Header'.
    " @see get_random_table description
    ls_root-t      = cl_main=>get_random_table( ).

    " Date and time in header and footer
    ls_root-date   = sy-datum.
    ls_root-time   = sy-uzeit.
    " obligatory only for datetime   (;type=datetime)
    CONCATENATE sy-datum sy-uzeit INTO ls_root-datetime.
  ENDIF.

  " Show data structure only
  IF p_stru = abap_true.
    check_break_point_id( ).
    BREAK-POINT ID zxtt_break_point. " Double click here --> ls_root <--
    RETURN.
  ENDIF.

  " Info about template & the main class itself
  CREATE OBJECT:
   lo_file TYPE zcl_xtt_file_smw0 EXPORTING
     iv_objid = iv_template,

   ro_xtt TYPE (iv_class_name) EXPORTING
    io_file = lo_file.

  " Paste data
  IF p_temp <> abap_true.
    ro_xtt->merge( is_block = ls_root iv_block_name = 'R' ).
  ENDIF.
ENDMETHOD.
