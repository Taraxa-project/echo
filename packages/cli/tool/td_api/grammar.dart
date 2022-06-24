import 'package:petitparser/petitparser.dart';
import 'tl.dart';

class TlGrammarDefinition extends GrammarDefinition {
  Parser newline = Token.newlineParser();

  Parser start() => ref0(term).end();

  Parser term() => (ref0(definition) | ref0(switchToFunctions)).star();

  Parser definition() =>
      (ref0(commments).star() & ref0(constructor)).map((value) => TlDefinition(
            constructor: value.last,
            comments: value.take(value.length - 1).toList().cast<TlComment>(),
          ));

  Parser commments() => ref0(comment);
  Parser comment() =>
      ((string('//') & noneOf('\n\r').star().flatten() & newline.star())
          .map((value) => value[1])
          .flatten()
          .map((value) => value)).map((value) => TlComment(text: value));

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
      (noneOf(';').plus().flatten() & char(';') & newline.star())
          .map((value) => TlType(name: value[0]));

  Parser switchToFunctions() =>
      (string('---functions---') & newline.star()).map((value) => TlSwitch());
}
