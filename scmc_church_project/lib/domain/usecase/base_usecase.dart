import 'package:dartz/dartz.dart';

/// clean-architecture의 UseCase 규칙 : 한 개의 행동을 담당, Input과 Output의 단일 실행 메서드만 외부에 제공한다.
abstract class BaseUseCase<Params, Result> {
  Future<Either<String, Result>> execute(Params params);
}
