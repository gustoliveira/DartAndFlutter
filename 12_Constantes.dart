void main() {
  final cityName = 'Mumbai';
	final String countryName = name();

	const PI = 3.14159;
	const double gravity = 9.8;

  final continentName = name();
  /*
  This can be done because final accepts a value at run time,
  so it is not fixed when compiling the program
  */

  // const PI = number(); Throws an error
  /*
  This cannot be done, as the value is already defined when compiling,
  as a function will only have the value defined at run time,
  the compiler doesn't accept
  */
}

String name(){
  return 'Europe';
}

double number(){
  return 3.14159;
}
