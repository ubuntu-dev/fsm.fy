require: "fsm"

numbers_only = FSM new: {
  non_digit = /[^0-9]/
  digit     = /[0-9]/
  done      = /\s/ >< ""

  start: @{
    + digit -> parse_num
  }

  final parse_num: @{
    + digit -> parse_num
    + "."   -> parse_decimal
    + done  -> end
    + _     -> fail
  }

  final parse_decimal: @{
    + digit -> parse_decimal
    + done  -> end
    + _     -> fail
  }

  loop fail
}

numbers_only <- "0"         . println
numbers_only <- "123"       . println
numbers_only <- "123 "      . println
numbers_only <- "123.0123"  . println
numbers_only <- "123.0123 " . println
numbers_only <- "123a"      . println

{ numbers_only <- "a"    } call_with_errors_logged
{ numbers_only <- "a123" } call_with_errors_logged
