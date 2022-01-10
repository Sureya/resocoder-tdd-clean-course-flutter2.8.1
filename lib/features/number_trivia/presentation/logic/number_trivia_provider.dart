import 'package:bloc_course/core/errors/failure.dart';
import 'package:bloc_course/core/network/network_info.dart';
import 'package:bloc_course/core/util/input_conversion.dart';
import 'package:bloc_course/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:bloc_course/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:bloc_course/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloc_course/features/number_trivia/presentation/logic/number_trivia_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'number_trivia__state_notifier.dart';


///Dependency Injection

final _sharedPreferenceProvider = FutureProvider<SharedPreferences>(
        (ref) async  => await SharedPreferences.getInstance()
);


final _inputConverterProvider = Provider<InputConverter>(
      (ref) => InputConverter(),
);

final _networkProvider = Provider<NetworkInfoImpl>(
      (ref) => NetworkInfoImpl(InternetConnectionChecker()),
);

final _localDataSourceProvider = Provider<NumberTriviaLocalDataSourceImpl>(
      (ref) => NumberTriviaLocalDataSourceImpl(
          sharedPreferences: ref.watch(_sharedPreferenceProvider).maybeWhen(
            data:(d) => d,
            orElse: () => throw Exception("Shared Preference Can't be initialized"),
          )
      ),
);


final _remoteDataSourceProvider = Provider<NumberTriviaRemoteDataSourceImpl>(
      (ref) => NumberTriviaRemoteDataSourceImpl(
          dioClient: Dio()
      )
);


final _concreteTriviaProvider = Provider<GetConcreteNumberTrivia>(
      (ref) => GetConcreteNumberTrivia(
          repository: NumberTriviaRepositoryImpl(
              networkInfo: ref.watch(_networkProvider),
              numberTriviaLocalDataSource: ref.watch(_localDataSourceProvider),
              numberTriviaRemoteDataSource: ref.watch(_remoteDataSourceProvider)
          )
      )
);

final _randomTriviaProvider = Provider<GetRandomNumberTrivia>(
        (ref) => GetRandomNumberTrivia(
        NumberTriviaRepositoryImpl(
            networkInfo: ref.watch(_networkProvider),
            numberTriviaLocalDataSource: ref.watch(_localDataSourceProvider),
            numberTriviaRemoteDataSource: ref.watch(_remoteDataSourceProvider)
        )
    )
);


final numberTriviaProvider = StateNotifierProvider<NumberTriviaNotifier, NumberTriviaState>(
      (ref) => NumberTriviaNotifier(
      getRandomNumberTrivia: ref.watch(_randomTriviaProvider),
      getConcreteNumberTrivia: ref.watch(_concreteTriviaProvider),
      inputConverter: ref.watch(_inputConverterProvider),


  ),
);
