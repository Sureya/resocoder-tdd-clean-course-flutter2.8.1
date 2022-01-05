import 'package:bloc_course/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late MockDataConnectionChecker mockDataConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  test('should forward the call to DataConnectionChecker.hasConnection',
      () async {
    final tHasConnectionFuture = Future.value(true) ;

    // arrange
    when(() => mockDataConnectionChecker.hasConnection)
        .thenAnswer((_) => tHasConnectionFuture);

    // act
    final result = networkInfoImpl.isConnected ;

    // assert
    verify(() => mockDataConnectionChecker.hasConnection);
    expect(result, tHasConnectionFuture);
  });
}
