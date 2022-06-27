import 'package:petitparser/petitparser.dart';
import 'tl.dart';

class TlGrammarDefinition extends GrammarDefinition {
  Parser newline = Token.newlineParser();

  Parser start() => ref0(term).end();

  Parser term() =>
      (ref0(object).plus() & ref0(switchToFunctions) & ref0(function).plus())
          .map((value) => [value[0], value[2]]);

  Parser object() => (ref0(definition)).map((value) => TlObject(
        constructor: value.constructor,
        comments: value.comments,
      ));
  Parser function() => (ref0(definition)).map((value) => TlFunction(
        constructor: value.constructor,
        comments: value.comments,
      ));

  Parser definition() =>
      (ref0(comment) & ref0(constructor)).map((value) => TlDefinition(
            constructor: value.last,
            comments:
                value.take(value.length - 1).toList().cast<TlCommentValue>(),
          ));

  Parser comment() => ref0(classComment);

  Parser classComment() =>
      ref0(astractClassComment).star() &
      ref0(classCommentBegin) &
      ref0(commentContinued).star() &
      (ref0(paramComment) & ref0(commentContinued).star()).star();

  Parser astractClassComment() => (string('//@class') &
          whitespace().star() &
          noneOf(' ').plus().flatten() &
          whitespace().star() &
          string('@description ') &
          noneOf('\n\r').star().flatten() &
          whitespace().star())
      .map((value) => TlAbstractClassComment(text: value[5]));
  Parser classCommentBegin() => (string('//@description ') &
          noneOf('\n\r@').star().flatten() &
          whitespace().star())
      .map((value) => value[1]);
  Parser commentContinued() =>
      (string('//-') & noneOf('\n\r@').star().flatten() & whitespace().star())
          .map((value) => value[1]);
  Parser paramComment() =>
      (string('//@') | string('@')) &
      noneOf(' @').plus().flatten() &
      whitespace().star() &
      noneOf('@\n\r').star().flatten() &
      whitespace().star();

  Parser constructor() => (ref0(name) &
          ref0(param).star() &
          (char('=') & whitespace().plus()) &
          ref0(resultType))
      .map((value) => TlConstructor(
            name: value[0],
            params: value[1].cast<TlParam>(),
            returnType: value[3],
          ));
  Parser name() => (noneOf('\n\r-/ ').plus().flatten() & whitespace().plus())
      .map((value) => value[0]);
  Parser param() => (ref0(paramName) & ref0(paramType)).map((value) => TlParam(
        name: value[0],
        type: value[1],
      ));
  Parser paramName() =>
      (noneOf(':=').plus().flatten() & char(':')).map((value) => value[0]);
  Parser paramType() => (noneOf(' ').plus().flatten() & whitespace().plus())
      .map((value) => TlType(
            name: value[0],
          ));
  Parser resultType() =>
      (noneOf(';').plus().flatten() & char(';') & whitespace().star())
          .map((value) => TlType(name: value[0]));

  Parser switchToFunctions() => string('---functions---') & whitespace().star();
}
