import 'dart:math';
import 'package:pool_rides/models/cars.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';

// ---------------------------------------------------
// --------------------- CARS ------------------------
// ---------------------------------------------------

List<Cars> cars = [
  Cars(
    model: "Chevrolet Aveo",
    color: "blanco",
    image:
        "https://www.chevrolet.com.mx/content/dam/chevrolet/na/mx/es/index/cars/2020-aveo/colorizer/01-images/azul-pacifico.jpg?imwidth=960",
  ),
  Cars(
    model: "Mazda 2",
    color: "gris",
    image:
        "https://www.mazda.mx/siteassets/mazda-mx/mycos-2021/mazda2-hatchback/vlp/360/gris-titanio/mazda2-hb-gris-titanio-ext-360-02-24-s.jpg",
  ),
  Cars(
    model: "Volkswagen PASSAT",
    color: "Azul",
    image: "https://fotos02.autofacil.es/2019/06/25/690x278/iris.jpg",
  ),
  Cars(
    model: "Toyota Corolla",
    color: "blanco",
    image:
        "https://www.excelenciasdelmotor.com/sites/default/files/2019-11/portada_corolla.jpg",
  ),
  Cars(
    model: "Volkswagen Jetta",
    color: "negro",
    image:
        "https://img.automexico.com/2020/05/19/i8InHrze/jetta-precios-5-4c7d.jpg",
  ),
  Cars(
    model: "Nissan Sentra",
    color: "plata",
    image:
        "https://www.revistaturbo.com/sites/default/files/nissansentra_0.jpg",
  ),
  Cars(
    model: "Nissan Altima",
    color: "rojo",
    image:
        "https://www.nissan.com.mx/content/dam/Nissan/mexico/vehicles/Altima/MY19/VAP/altima-grade-19-terantbwa-uslhd-pace.jpg.ximg.l_6_m.smart.png",
  ),
  Cars(
    model: "Chevrolet Malibu",
    color: "plata",
    image:
        "https://www.chevrolet.com/content/dam/chevrolet/na/us/english/index/vehicles/2021/cars/malibu/colorizer/01-images/2021-malibu-1zs69-gaz-colorizer.jpg?imwidth=960",
  ),
];

// ---------------------------------------------------
// --------------------- USERS -----------------------
// ---------------------------------------------------

List<User> users = [
  User(
    name: "Edgar Medina Rifas",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",
    image: "",
    age: 22,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(1).nextInt(7)]],
    email: "Edgar@iteso.mx",
    phoneNumber: "3164973164",
  ),
  User(
    name: "Mauricio Durán Padilla",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
    image: "https://randomuser.me/portraits/men/2.jpg",
    age: 22,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(2).nextInt(7)]],
    email: "Mauricio@iteso.mx",
    phoneNumber: "3164973165",
  ),
  User(
    name: "Anahí Santana",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
    image: "https://randomuser.me/portraits/women/2.jpg",
    age: 23,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(3).nextInt(7)]],
    email: "Anahi@iteso.mx",
    phoneNumber: "3164973166",
  ),
  User(
    name: "Martín Casillas",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
    image: "https://randomuser.me/portraits/men/2.jpg",
    age: 23,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(4).nextInt(7)]],
    email: "Martin@iteso.mx",
    phoneNumber: "3164973167",
  ),
  User(
    name: "Omar Soto",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",
    image: "https://randomuser.me/portraits/men/3.jpg",
    age: 21,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(5).nextInt(7)]],
    email: "Omar@iteso.mx",
    phoneNumber: "3164973168",
  ),
  User(
    name: "Fernando Franco",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
    image: "https://randomuser.me/portraits/men/6.jpg",
    age: 21,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(6).nextInt(7)]],
    email: "Fernando@iteso.mx",
    phoneNumber: "3164973169",
  ),
  User(
    name: "Gustavo Rueda",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",
    image: "https://randomuser.me/portraits/men/4.jpg",
    age: 22,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(7).nextInt(7)]],
    email: "Gustavo@iteso.mx",
    phoneNumber: "3164973170",
  ),
  User(
    name: "Salvador Gonzalez",
    biography:
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
    image: "https://randomuser.me/portraits/men/5.jpg",
    age: 22,
    tripNumber: Random().nextInt(1000),
    reviewsNumber: Random().nextInt(1000),
    stars: (Random().nextDouble() * 4 + 1),
    joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
    reviews: null,
    cars: [cars[Random(8).nextInt(7)]],
    email: "Salvador@iteso.mx",
    phoneNumber: "3164973171",
  ),
];

// ---------------------------------------------------
// --------------------- Trip -----------------------
// ---------------------------------------------------

List<Trip> trips = [
  Trip(
    startTime: "3:00",
    arrivalTime: "5:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Chedraui, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[0],
    passengers: users.getRange(3, 7).toList(),
    isCarSpecified: true,
    car: users[0].cars[0],
  ),
  Trip(
    startTime: "4:00",
    arrivalTime: "6:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Hotel Riu Plaza, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[1],
    passengers: users.getRange(4, 6).toList(),
    isCarSpecified: false,
  ),
  Trip(
    startTime: "5:00",
    arrivalTime: "7:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Hotel Riu Plaza, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[2],
    passengers: users.getRange(0, 2).toList(),
    isCarSpecified: true,
    car: users[2].cars[0],
  ),
  Trip(
    startTime: "6:00",
    arrivalTime: "8:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Hotel Riu Plaza, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[3],
    passengers: users.getRange(0, 1).toList(),
    isCarSpecified: false,
  ),
  Trip(
    startTime: "7:00",
    arrivalTime: "9:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Hotel Riu Plaza, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[4],
    passengers: users.getRange(2, 4).toList(),
    isCarSpecified: true,
    car: users[4].cars[0],
  ),
  Trip(
    startTime: "8:00",
    arrivalTime: "10:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Hotel Riu Plaza, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[5],
    passengers: users.getRange(1, 2).toList(),
    isCarSpecified: false,
  ),
  Trip(
    startTime: "9:00",
    arrivalTime: "11:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Hotel Riu Plaza, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[6],
    passengers: users.getRange(0, 2).toList(),
    isCarSpecified: true,
    car: users[6].cars[0],
  ),
  Trip(
    startTime: "10:00",
    arrivalTime: "12:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    originName: "Guadalajara",
    destinationName: "Colima",
    originLocation: "Hotel Riu Plaza, Guadalajara Colón, San Pedro Tlaquepaque",
    destinationLocation: "Catedral Basílica Menor, Colima Centro, Colima Col",
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[7],
    passengers: users.getRange(0, 1).toList(),
    isCarSpecified: false,
  ),
];
