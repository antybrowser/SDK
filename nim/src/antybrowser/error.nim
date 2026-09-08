type
  AntybrowserError* = ref object of CatchableError
    statusCode*: int
    responseBody*: string

proc newAntybrowserError*(message: string, statusCode: int, responseBody: string): AntybrowserError =
  result = AntybrowserError(msg: message, statusCode: statusCode, responseBody: responseBody)
