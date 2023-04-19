import 'package:petitparser/petitparser.dart';
import 'tl.dart';

class TlGrammarDefinition extends GrammarDefinition {
  Parser newline = Token.newlineParser();

  Parser start() => ref0(term).end();

  Parser term() => (ref0(ignorePrimitives) &
          ref0(object).plus() &
          ref0(switchToFunctions) &
          ref0(function).plus())
      .map((value) => [value[1], value[3]]);

  Parser ignorePrimitives() => noneOf('/').star().flatten();
  Parser object() => (ref0(definition)).map((value) => TlObject(
        constructor: value.constructor,
        comment: value.comment,
      ));
  Parser function() => (ref0(definition)).map((value) => TlFunction(
        constructor: value.constructor,
        comment: value.comment,
      ));

  Parser definition() =>
      (ref0(comment) & ref0(constructor)).map((value) => TlDefinition(
            constructor: value[1],
            comment: TlComment(
              abstractClassComment:
                  value[0][0].length > 0 ? value[0][0][0] : null,
              classComment: value[0][1],
              paramComments: value[0][2].cast<TlParamComment>().toList(),
            ),
          ));

  Parser comment() =>
      ref0(astractClassComment).star() &
      ref0(classComment) &
      ref0(paramComment).star();

  Parser classComment() =>
      (ref0(classCommentBegin) & ref0(classCommentContinued).star()).map(
          (value) => TlClassComment(
              text: value[0],
              nextLines: value[1]
                  .map((v) => TlCommentValue(text: v))
                  .toList()
                  .cast<TlCommentValue>()
                  .toList()));

  Parser astractClassComment() => (string('//@class') &
          whitespace().star() &
          noneOf(' ').plus().flatten() &
          whitespace().star() &
          string('@description ') &
          noneOf('\n\r').star().flatten() &
          whitespace().star() &
          ref0(classCommentContinued).star())
      .map((value) => TlAbstractClassComment(
          text: value[5],
          nextLines: value[7]
              .map((v) => TlCommentValue(text: v))
              .toList()
              .cast<TlCommentValue>()
              .toList()));

  Parser classCommentBegin() => (string('//@description ') &
          noneOf('\n\r@').star().flatten() &
          whitespace().star())
      .map((value) => value[1]);
  Parser classCommentContinued() =>
      (string('//-') & noneOf('\n\r@').star().flatten() & whitespace().star())
          .map((value) => value[1]);

  Parser paramComment() =>
      (ref0(paramCommentBegin) & ref0(paramCommentContinued).star())
          .map((value) => TlParamComment(
                text: value[0][3],
                paramName: value[0][1],
                nextLines: value[1]
                    .map((v) => TlCommentValue(text: v))
                    .toList()
                    .cast<TlCommentValue>()
                    .toList(),
              ));
  Parser paramCommentBegin() =>
      (string('//@') | string('@')) &
      noneOf(' @').plus().flatten() &
      whitespace().star() &
      noneOf('@\n\r').star().flatten() &
      whitespace().star();
  Parser paramCommentContinued() =>
      (string('//-') & noneOf('\n\r@').star().flatten() & whitespace().star())
          .map((value) => value[1]);

  Parser constructor() => (ref0(name) &
          ref0(param).star() &
          (char('=') & whitespace().plus()) &
          ref0(resultType))
      .map((value) => TlConstructor(
            name: value[0],
            params: value[1].cast<TlParam>().toList(),
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
