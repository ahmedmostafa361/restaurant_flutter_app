import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/auth/user_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';

void main() {
  group('UserResponseDtoMapper', () {
    test('maps all fields correctly to domain', () {
      final dto = UserResponseDto(
        userEmail: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
        userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
      );

      final domain = dto.toDomain();

      expect(domain.userEmail, 'ahmed@bachelor.com');
      expect(domain.password, 'sonicmaster1');
      expect(domain.userCode, 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
    });
  });
}