import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/auth/register_request_mappers.dart'; // adjust path to match your lib/ structure
import 'package:restaurant_flutter_app/api/model/request/register_request_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';

void main() {
  group('RegisterRequestMapper', () {
    test(
      'toDto() maps every field from RegisterRequest to RegisterRequestDto',
      () {
        // Arrange
        final registerRequest = RegisterRequest(
          userEmail: 'test@example.com',
          password: 'P@ssw0rd123',
        );

        // Act
        final dto = registerRequest.toDto();

        // Assert
        expect(dto, isA<RegisterRequestDto>());
        expect(dto.userEmail, registerRequest.userEmail);
        expect(dto.password, registerRequest.password);
      },
    );

    test('toDto() does not mutate or drop empty string values', () {
      final registerRequest = RegisterRequest(userEmail: '', password: '');

      final dto = registerRequest.toDto();

      expect(dto.userEmail, '');
      expect(dto.password, '');
    });
  });
}
