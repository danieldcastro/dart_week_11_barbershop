sealed class Either<E extends Error, S> {}

class Failure<E extends Error, S> extends Either<E, S> {
  final E error;
  Failure(this.error);
}

class Success<E extends Error, S> extends Either<E, S> {
  final S value;
  Success(this.value);
}
