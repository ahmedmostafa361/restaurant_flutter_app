import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/auth/user_code_login_response_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_code_login_response_dto.dart';

void main() {
  group('LoginResponseDtoMapper', () {
    test(
        'maps userCode correctly to domain, matching the real API response', () {
      // Real response captured from GET /User/getusercode
      final dto = LoginResponseDto(
          userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');

      final domain = dto.toDomain();

      expect(domain.userCode, 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
    });

    test(
        'maps null userCode without throwing — covers the invalid-credentials case', () {
      final dto = LoginResponseDto(userCode: null);

      final domain = dto.toDomain();

      expect(domain.userCode, isNull);
    });
  });
}