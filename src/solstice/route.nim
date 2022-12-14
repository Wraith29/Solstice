import 
  options

type
  RouteVariableKind = enum
    String
    Int
  
  RouteVariable* = ref object
    name: string
    case kind: RouteVariableKind:
    of String: strVal*: string
    of Int: intVal*: int

  RequestArgs* = varargs[RouteVariable]

proc newRouteVariable*(name, value: string): RouteVariable =
  new result
  result.name = name
  result.kind = RouteVariableKind.String
  result.strVal = value

proc newRouteVariable*(name: string, value: int): RouteVariable =
  new result
  result.name = name
  result.kind = RouteVariableKind.Int
  result.intval = value

proc get*(args: RequestArgs, name: string): Option[RouteVariable] =
  for arg in args:
    if arg.name == name:
      return some(arg)
  none(RouteVariable)

proc `[]`*(args: RequestArgs, name: string): Option[RouteVariable] =
  for arg in args:
    if arg.name == name:
      return some(arg)
  none(RouteVariable)
