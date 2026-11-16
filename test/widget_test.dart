import 'package:flutter_test/flutter_test.dart';
import 'package:sixam_mart/util/app_constants.dart';

void main() {
  test('AppConstants B.Laban configuration verification', () {
    expect(AppConstants.appName, 'B.Laban');
    expect(AppConstants.baseUrl, 'https://admin.domains4gulf.com');
    expect(AppConstants.webHostedUrl, 'https://store.domains4gulf.com');
    expect(AppConstants.defaultLatitude, '29.3759');
    expect(AppConstants.defaultLongitude, '47.9774');
    expect(AppConstants.defaultZoneId, 6);
    expect(AppConstants.defaultZoneIds, contains(6));
  });
}
