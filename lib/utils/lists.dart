import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pool_rides/models/car.dart';
import 'package:pool_rides/models/conversation-user.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/models/latilong.dart';
import 'package:pool_rides/models/message.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';

// ---------------------------------------------------
// --------------------- PLACES ------------------------
// ---------------------------------------------------

List<Place> places = [
  Place(
    streetNumber: "3460",
    street: "Independencia",
    city: "Tonalá",
    zipCode: "45682",
    coordinates: LatiLong(lat: 20.5747, long: -103.4116),
    bounds: LatLngBounds(
      southwest: LatLng(20.5747, -103.4116),
      northeast: LatLng(20.5747, -103.4116),
    ),
    placeId: "123abc",
    description: "ITESO",
  ),
  Place(
    streetNumber: "3465",
    street: "Acapulco",
    city: "Tlaquepaque",
    zipCode: "45687",
    coordinates: LatiLong(lat: 20.5747, long: -103.4116),
    bounds: LatLngBounds(
      southwest: LatLng(70.5747, -12.4116),
      northeast: LatLng(70.5747, -12.4116),
    ),
    placeId: "123abc",
    description: "wizeline",
  ),
  Place(
    streetNumber: "3875",
    street: "Lopez Mateos",
    city: "Guadalajara",
    zipCode: "45123",
    coordinates: LatiLong(lat: 20.5747, long: -103.4116),
    bounds: LatLngBounds(
      southwest: LatLng(200.5747, -50.4116),
      northeast: LatLng(200.5747, -50.4116),
    ),
    placeId: "123abc",
    description: "intel",
  ),
];

// ---------------------------------------------------
// --------------------- CARS ------------------------
// ---------------------------------------------------

List<Car> cars = [
  Car(
    model: "Chevrolet Aveo",
    color: "blanco",
    image:
        "https://www.chevrolet.com.mx/content/dam/chevrolet/na/mx/es/index/Car/2020-aveo/colorizer/01-images/azul-pacifico.jpg?imwidth=960",
  ),
  Car(
    model: "Mazda 2",
    color: "gris",
    image:
        "https://www.mazda.mx/siteassets/mazda-mx/mycos-2021/mazda2-hatchback/vlp/360/gris-titanio/mazda2-hb-gris-titanio-ext-360-02-24-s.jpg",
  ),
  Car(
    model: "Volkswagen PASSAT",
    color: "Azul",
    image: "https://fotos02.autofacil.es/2019/06/25/690x278/iris.jpg",
  ),
  Car(
    model: "Toyota Corolla",
    color: "blanco",
    image:
        "https://www.excelenciasdelmotor.com/sites/default/files/2019-11/portada_corolla.jpg",
  ),
  Car(
    model: "Volkswagen Jetta",
    color: "negro",
    image:
        "https://img.automexico.com/2020/05/19/i8InHrze/jetta-precios-5-4c7d.jpg",
  ),
  Car(
    model: "Nissan Sentra",
    color: "plata",
    image:
        "https://www.revistaturbo.com/sites/default/files/nissansentra_0.jpg",
  ),
  Car(
    model: "Nissan Altima",
    color: "rojo",
    image:
        "https://www.nissan.com.mx/content/dam/Nissan/mexico/vehicles/Altima/MY19/VAP/altima-grade-19-terantbwa-uslhd-pace.jpg.ximg.l_6_m.smart.png",
  ),
  Car(
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
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(1).nextInt(7)],
      email: "Edgar@iteso.mx",
      phoneNumber: "3164973164",
      birthdate: DateTime.now()),
  User(
      name: "Mauricio Durán Padilla",
      biography:
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
      image: "https://randomuser.me/portraits/men/2.jpg",
      age: 22,
      tripNumber: Random().nextInt(1000),
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(2).nextInt(7)],
      email: "Mauricio@iteso.mx",
      phoneNumber: "3164973165",
      birthdate: DateTime.now()),
  User(
      name: "Anahí Santana",
      biography:
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
      image: "https://randomuser.me/portraits/women/2.jpg",
      age: 23,
      tripNumber: Random().nextInt(1000),
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(3).nextInt(7)],
      email: "Anahi@iteso.mx",
      phoneNumber: "3164973166",
      birthdate: DateTime.now()),
  User(
      name: "Martín Casillas",
      biography:
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
      image: "https://randomuser.me/portraits/men/2.jpg",
      age: 23,
      tripNumber: Random().nextInt(1000),
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(4).nextInt(7)],
      email: "Martin@iteso.mx",
      phoneNumber: "3164973167",
      birthdate: DateTime.now()),
  User(
      name: "Omar Soto",
      biography:
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",
      image: "https://randomuser.me/portraits/men/3.jpg",
      age: 21,
      tripNumber: Random().nextInt(1000),
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(5).nextInt(7)],
      email: "Omar@iteso.mx",
      phoneNumber: "3164973168",
      birthdate: DateTime.now()),
  User(
      name: "Fernando Franco",
      biography:
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
      image: "https://randomuser.me/portraits/men/6.jpg",
      age: 21,
      tripNumber: Random().nextInt(1000),
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(6).nextInt(7)],
      email: "Fernando@iteso.mx",
      phoneNumber: "3164973169",
      birthdate: DateTime.now()),
  User(
      name: "Gustavo Rueda",
      biography:
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",
      image: "https://randomuser.me/portraits/men/4.jpg",
      age: 22,
      tripNumber: Random().nextInt(1000),
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(7).nextInt(7)],
      email: "Gustavo@iteso.mx",
      phoneNumber: "3164973170",
      birthdate: DateTime.now()),
  User(
      name: "Salvador Gonzalez",
      biography:
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas 'Letraset', las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
      image: "https://randomuser.me/portraits/men/5.jpg",
      age: 22,
      tripNumber: Random().nextInt(1000),
      joined: DateTime.now().subtract(Duration(days: Random().nextInt(1000))),
      reviews: null,
      car: cars[Random(8).nextInt(7)],
      email: "Salvador@iteso.mx",
      phoneNumber: "3164973171",
      birthdate: DateTime.now()),
];

// ---------------------------------------------------
// --------------------- Trip -----------------------
// ---------------------------------------------------

List<Trip> tripList = [
  Trip(
    startTime: "3:00",
    arrivalTime: "5:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[0],
    destination: places[1],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[0],
    passengers: users.getRange(3, 7).toList(),
    isCarSpecified: true,
    car: users[0].car,
    passengerCapacity: 4,
  ),
  Trip(
    startTime: "4:00",
    arrivalTime: "6:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[1],
    destination: places[2],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[1],
    passengers: users.getRange(4, 6).toList(),
    isCarSpecified: false,
    passengerCapacity: 4,
  ),
  Trip(
    startTime: "5:00",
    arrivalTime: "7:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[2],
    destination: places[0],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[2],
    passengers: users.getRange(0, 2).toList(),
    isCarSpecified: true,
    car: users[2].car,
    passengerCapacity: 2,
  ),
  Trip(
    startTime: "6:00",
    arrivalTime: "8:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[0],
    destination: places[1],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[3],
    passengers: users.getRange(0, 1).toList(),
    isCarSpecified: false,
    passengerCapacity: 4,
  ),
  Trip(
    startTime: "7:00",
    arrivalTime: "9:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[1],
    destination: places[0],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[4],
    passengers: users.getRange(2, 4).toList(),
    isCarSpecified: true,
    car: users[4].car,
    passengerCapacity: 4,
  ),
  Trip(
    startTime: "8:00",
    arrivalTime: "10:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[2],
    destination: places[1],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[5],
    passengers: users.getRange(1, 2).toList(),
    isCarSpecified: false,
    passengerCapacity: 3,
  ),
  Trip(
    startTime: "9:00",
    arrivalTime: "11:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[0],
    destination: places[2],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[6],
    passengers: users.getRange(0, 2).toList(),
    isCarSpecified: true,
    car: users[6].car,
    passengerCapacity: 3,
  ),
  Trip(
    startTime: "10:00",
    arrivalTime: "12:00",
    tripPrice: (Random().nextDouble() * 100 + 150),
    origin: places[2],
    destination: places[1],
    departureDate: DateTime.now().add(Duration(days: Random().nextInt(30))),
    driver: users[7],
    passengers: users.getRange(0, 1).toList(),
    isCarSpecified: false,
    passengerCapacity: 4,
  ),
];

// ---------------------------------------------------
// ------------------- Messages ----------------------
// ---------------------------------------------------

List<ChatMessage> messages = [
  ChatMessage(
    messageContent: "Hello, Rolas",
    messageSender: "mau4duran",
    date: DateTime.now().subtract(
      Duration(days: 7, hours: 6, minutes: 20),
    ),
  ),
  ChatMessage(
      messageContent: "How have you been?",
      messageSender: "mau4duran",
      date: DateTime.now().subtract(
        Duration(days: 1),
      )),
  ChatMessage(
    messageContent: "Hey Mau, I am doing fine dude. wbu?",
    messageSender: "rolas",
    date: DateTime.now().subtract(
      Duration(days: 1),
    ),
  ),
  ChatMessage(
      messageContent:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam convallis nibh non metus semper, eu congue tellus mollis. Vivamus euismod pretium leo quis feugiat. Morbi lobortis, eros id viverra aliquam, dolor neque gravida massa, et sollicitudin urna erat vel nunc. Sed posuere porttitor tincidunt. Vivamus suscipit sagittis elit vel ultrices. Sed tempus varius libero et vestibulum. Quisque ante enim, bibendum eu nunc ut, commodo tempor libero.",
      messageSender: "rolas",
      date: DateTime.now().subtract(
        Duration(days: 2),
      )),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageSender: "mau4duran",
    date: DateTime.now(),
  ),
];

// ------------------------------------------------------------
// ------------------- ConversationUsers ----------------------
// ------------------------------------------------------------

ConversationUser mau4duran = ConversationUser(
    userId: 'mau4duran',
    name: 'Mauricio Duran',
    image: 'https://randomuser.me/api/portraits/men/4.jpg',
    email: 'mau4-duran@hotmail.com',
    phoneNumber: '4441606214');

ConversationUser ipanchomx = ConversationUser(
    userId: 'ipanchomx',
    name: 'Edgar Rolas',
    image: 'https://randomuser.me/api/portraits/men/5.jpg',
    email: 'ipanchomx@hotmail.com',
    phoneNumber: '3341606214');

ConversationUser jprr44 = ConversationUser(
    userId: 'jprr44',
    name: 'Abdul Ramos',
    image: 'https://randomuser.me/api/portraits/men/6.jpg',
    email: 'jprr44@hotmail.com',
    phoneNumber: '3341606123');

ConversationUser cdaG = ConversationUser(
    userId: 'cda_g',
    name: 'Ana Gabriela Cabral',
    image: 'https://randomuser.me/api/portraits/women/5.jpg',
    email: 'cda_g@hotmail.com',
    phoneNumber: '4441606123');

// --------------------------------------------------------
// ------------------- Conversations ----------------------
// --------------------------------------------------------

List<Conversation> conversations = [
  Conversation(
    conversationId: "1",
    members: [mau4duran, ipanchomx],
    originCity: 'Guadalajara',
    destinationCity: 'San Luis Potosí',
    dateOfCreation: DateTime.now(),
  ),
  Conversation(
    conversationId: "2",
    members: [mau4duran, jprr44],
    originCity: 'Guadalajara',
    destinationCity: 'San Luis Potosí',
    dateOfCreation: DateTime.now().subtract(Duration(days: 10)),
  ),
  Conversation(
    conversationId: "2",
    members: [mau4duran, cdaG],
    originCity: 'Guadalajara',
    destinationCity: 'San Luis Potosí',
    lastMessage: messages[messages.length - 1],
    messages: messages,
    dateOfCreation: DateTime.now().subtract(Duration(days: 7)),
  ),
  Conversation(
    conversationId: "1",
    members: [mau4duran, ipanchomx],
    originCity: 'Guadalajara',
    destinationCity: 'Toluca',
    dateOfCreation: DateTime.now().subtract(Duration(days: 12)),
  ),
  Conversation(
    conversationId: "2",
    members: [mau4duran, jprr44],
    originCity: 'Ciudad de Mexico',
    destinationCity: 'San Luis Potosí',
    dateOfCreation: DateTime.now().subtract(Duration(days: 5)),
  ),
  Conversation(
    conversationId: "2",
    members: [mau4duran, cdaG],
    originCity: 'Monterrey',
    destinationCity: 'San Luis Potosí',
    lastMessage: messages[messages.length - 1],
    messages: messages,
    dateOfCreation: DateTime.now().subtract(Duration(days: 2)),
  ),
];

String marcasCoches =
    '{"0":"Abarth","1":"Alfa Romeo","2":"Aro","3":"Asia","4":"Asia Motors","5":"Aston Martin","6":"Audi","7":"Austin","8":"Auverland","9":"Bentley","10":"Bertone","11":"Bmw","12":"Cadillac","13":"Chevrolet","14":"Chrysler","15":"Citroen","16":"Corvette","17":"Dacia","18":"Daewoo","19":"Daf","20":"Daihatsu","21":"Daimler","22":"Dodge","23":"Ferrari","24":"Fiat","25":"Ford","26":"Galloper","27":"Gmc","28":"Honda","29":"Hummer","30":"Hyundai","31":"Infiniti","32":"Innocenti","33":"Isuzu","34":"Iveco","35":"Iveco-pegaso","36":"Jaguar","37":"Jeep","38":"Kia","39":"Lada","40":"Lamborghini","41":"Lancia","42":"Land-rover","43":"Ldv","44":"Lexus","45":"Lotus","46":"Mahindra","47":"Maserati","48":"Maybach","49":"Mazda","50":"Mercedes-benz","51":"Mg","52":"Mini","53":"Mitsubishi","54":"Morgan","55":"Nissan","56":"Opel","57":"Peugeot","58":"Pontiac","59":"Porsche","60":"Renault","61":"Rolls-royce","62":"Rover","63":"Saab","64":"Santana","65":"Seat","66":"Skoda","67":"Smart","68":"Ssangyong","69":"Subaru","70":"Suzuki","71":"Talbot","72":"Tata","73":"Toyota","74":"Umm","75":"Vaz","76":"Volkswagen","77":"Volvo","78":"Wartburg"}';
