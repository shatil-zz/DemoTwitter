import 'package:demo_twitter/utils/format_validator.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Email validator', () {
    test('empty string', () async {
      expect(EmailValidator.isValidEmail(""), false);
    });
    test('normal string', () async {
      expect(EmailValidator.isValidEmail("esjhdv"), false);
    });
    test('with .com', () async {
      expect(EmailValidator.isValidEmail("asdvasd.com"), false);
    });
    test('with only @', () async {
      expect(EmailValidator.isValidEmail("asdvasd@com"), false);
    });
    test('valid email with special character', () async {
      expect(EmailValidator.isValidEmail("asjdjsd*233bcd#&@g.c"), true);
    });

    test('big text', () async {
      expect(
          EmailValidator.isValidEmail(
              "asjdjsd*23sdjkfaskdjgvkasdfgkjasdgfljkagsdfjgasd;kjfgaskjdfgkasjdgflaskjdhfl"
              "sfklgnbdsflkgnlsdkf"
              "sadjfbsl,fkdbgkdlnfknbdf"
              "sfdgjbdlfkjkldfg"
              "dsfjkgjkdbfgkjasdgfljgasdljfgasldjfgsljkadghfljsdghflkjghdsflgsdlfhlsdf3bcd#&@g.c"),
          false);
    });

    test('valid email without special character', () async {
      expect(EmailValidator.isValidEmail("abc34d@gmail.com"), true);
    });
  });

  group('Email field validator', () {
    FieldValidators fieldValidators = FieldValidators();
    test('null and empty string', () async {
      expect(fieldValidators.validateEmail(null), isNotNull);
      expect(fieldValidators.validateEmail(""), isNotNull);
    });
    test('Valid email', () async {
      expect(fieldValidators.validateEmail("sadjhfbkasfdb@gmail.com"), null);
    });
  });

  group('Password field validator', () {
    FieldValidators fieldValidators = FieldValidators();
    test('null and empty string', () async {
      expect(fieldValidators.validatePassword(null), isNotNull);
      expect(fieldValidators.validatePassword(""), isNotNull);
    });
    test('bellow four character', () async {
      expect(fieldValidators.validatePassword("abc"), isNotNull);
    });
    test('grater than 40 character', () async {
      expect(
          fieldValidators.validatePassword(
              "abcaskdjfbaskjdbfkjasbdfkjasbdfkjasbdfkjbasdfkjbaskdjfkjasdf"),
          isNotNull);
    });
    test('Valid password', () async {
      expect(fieldValidators.validatePassword("sadjhfbkasfdb"), null);
    });
  });
  group('Twit validator', () {
    FieldValidators fieldValidators = FieldValidators();
    test('null and empty string', () async {
      expect(fieldValidators.validateTwit(null), isNotNull);
      expect(fieldValidators.validateTwit(""), isNotNull);
    });

    test('Too long twit', () async {
      expect(
          fieldValidators.validateTwit("Hello world!!audsfgaskjdvfovjasdfgoasd"
              "sadfhjgsadkfgjasdf"
              "asdkfhksadfbjasbdfljbasldjfbasldjflasdflasdlfghasdlgfasdfg"
              "asdfhgasdkfgiasudgf8wyer0wrjbfksadufgiuasdfgohasdljvbiusdagfh"
              "asdfhasdoifhaoisdojfgouihouahsfgljknsdvuhsadfgohisagfihd"
              "sadfuosauidfghoiashdfgpiasfgdihkijwadfkjbasdoifhoasiugdfogusadugofguoasefguawogierfgoiuaweroguwras"
              "sadufgusagdfiugoasdfihishpdfapohsdfsfdgdgsdfgsdfg"),
          isNotNull);
    });
    test('Valid twit', () async {
      expect(fieldValidators.validateTwit("Hello world!!"), null);
    });
  });
}
