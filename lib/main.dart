import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: createThemeColor(CustomColors.purpleColor),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Анкета обладателей котиков'),
            centerTitle: true,
            titleTextStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: CustomColors.lightblueColor),
          ),
          body: const MyForm(),
        ),
        routes: {
          '/successfully': (context) => const SuccessfullForm(),
          '/home': (context) => const MyForm(),
        },
        initialRoute: '/',
      ),
    );

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();

  Map<String, bool> petFood = {
    'Сухой корм': false,
    'Влажный корм': false,
    'Натуральный корм': false,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildNamePet(),
            _buildNameYou(),
            _buildEmail(),
            _buildPhone(),
            _buildpBreedPet(),
            _buildFoodPet(),
            _buildGenderPet(),
            _buildTextButtonForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildNamePet() {
    return Column(
      children: [
        textNameForm('Кличка питомца'),
        TextFormField(
            decoration: inputDecoration(icon(Icons.cruelty_free), 'Симошка'),
            validator: (value) {
              if (value!.isEmpty) return 'Пожалуйста введите кличку птомца';
              return null;
            }),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget _buildNameYou() {
    return Column(
      children: [
        textNameForm('Ваше имя'),
        TextFormField(
            decoration: inputDecoration(icon(Icons.face), 'Анастасия'),
            validator: (value) {
              if (value!.isEmpty) return 'Пожалуйста введите ваше имя';
              return null;
            }),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      children: [
        textNameForm('Ваш E-mail'),
        TextFormField(
          decoration: inputDecoration(icon(Icons.email), 'info@mail.ru'),
          validator: (value) {
            if (value!.isEmpty) return 'Пожалуйста введите ваш E-mail';
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) return 'Введите корректный E-mail';
            return null;
          },
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget _buildPhone() {
    return Column(
      children: [
        textNameForm('Номер телефона'),
        TextFormField(
          decoration:
              inputDecoration(icon(Icons.phone_android), '+375(29)570-52-92'),
          keyboardType: TextInputType.phone,
          validator: ((value) {
            if (value!.isEmpty) return "Ведите номер телефона";
            return null;
          }),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildpBreedPet() {
    return Column(
      children: [
        textNameForm('Парода питомца'),
        TextFormField(
            decoration: inputDecoration(icon(Icons.pets_outlined), 'Метис'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Пожалуйста введите пароду питомца';
              }
              return null;
            }),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildFoodPet() {
    return Column(
      children: [
        textNameForm('Чем питается ваш любимец'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView(
            children: petFood.keys.map((String key) {
              return CheckboxListTile(
                title: textNamed(key),
                value: petFood[key],
                onChanged: (bool? value) {
                  setState(() {
                    petFood[key] = value!;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderPet() {
    return Column(
      children: [
        textNameForm('Выберите пол питомца'),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                title: textNamed('Самец'),
                value: GenderList.male,
                groupValue: gender,
                onChanged: (GenderList? value) {
                  setState(() {
                    if (value != null) gender = value;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                  title: textNamed('Самка'),
                  value: GenderList.female,
                  groupValue: gender,
                  onChanged: (GenderList? value) {
                    setState(() {
                      if (value != null) gender = value;
                    });
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextButtonForm() {
    return Column(
      children: [
        TextButtonForm(
          function: () {
            if (_formKey.currentState!.validate()) {
              Color color = CustomColors.redColor;
              String text;
              if (gender == null) {
                text = 'Выберите пол питомца';
              } else if (!petFood.containsValue(true)) {
                text = 'Пожалуйста выберите корм';
              } else {
                text = 'Форма успешно заполнена';
                Navigator.of(context).pushNamed('/successfully');
                color = CustomColors.purpleColor;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: CustomColors.lightblueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: color,
                ),
              );
            }
          },
          title: 'Сохранить',
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

class SuccessfullForm extends StatelessWidget {
  const SuccessfullForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Image.network(
              'https://i.pinimg.com/originals/6a/ea/b4/6aeab4020e5bda3d8350e0edd51f3104.jpg'),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Форма успешно заполнена',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: CustomColors.purpleColor,
              ),
            ),
          ),
          TextButtonForm(
            function: (() {
              Navigator.pop(context);
            }),
            title: 'Close',
          )
        ]),
      ),
    );
  }
}

enum GenderList { male, female }

GenderList? gender;

Text textNameForm(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: CustomColors.purpleColor),
  );
}

Text textNamed(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: CustomColors.blackColor),
  );
}

InputDecoration inputDecoration(Widget child, String hintText) {
  return InputDecoration(
    icon: child,
    hintText: hintText,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
}

Icon icon(IconData? icon, {Color color = CustomColors.blueColor}) {
  return Icon(
    icon,
    color: color,
  );
}

class CustomColors {
  static const Color purpleColor = Colors.purple;
  static const Color blueColor = Colors.blue;
  static const Color lightblueColor = Color(0xFF73B6EC);
  static const Color blackColor = Colors.black;
  static const Color redColor = Colors.red;
}

//Цвет темы
MaterialColor createThemeColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

//Экземпляр кнопки Сохранить/Закрыть
class TextButtonForm extends StatelessWidget {
  final String title;
  final Function function;
  const TextButtonForm({Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(CustomColors.lightblueColor),
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.height * 0.25,
            MediaQuery.of(context).size.height * 0.05,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () => function(),
      child: textNameForm(title),
    );
  }
}
