part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  HomeViewmodel homeViewmodel = HomeViewmodel();
  late TextEditingController _controller;

  @override
  void initState() {
    homeViewmodel.getProvinceList();
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  dynamic selectedProvince;
  dynamic selectedCity;
  dynamic selectedProvinceDest;
  dynamic selectedCityDest;
  dynamic selectedCourier;
  dynamic curWeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Calculate Cost"),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider<HomeViewmodel>(
          create: (context) => homeViewmodel,
          child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(children: [
                Flexible(
                    flex: 1,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Consumer<HomeViewmodel>(
                                  builder: (context, value, _) {
                                switch (value.provinceList.status) {
                                  case Status.loading:
                                    return Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    );
                                  case Status.error:
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Text(value.provinceList.message
                                          .toString()),
                                    );
                                  case Status.completed:
                                    return DropdownButton(
                                        isExpanded: true,
                                        value: selectedProvince,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 30,
                                        elevation: 2,
                                        hint: Text('Pilih Provinsi Asal'),
                                        style: TextStyle(color: Colors.black),
                                        items: value.provinceList.data!
                                            .map<DropdownMenuItem<Province>>(
                                                (Province value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child:
                                                Text(value.province.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedProvince = newValue;
                                            selectedCity = null;
                                            homeViewmodel.getCityList(
                                                selectedProvince.provinceId);
                                          });
                                        });
                                  default:
                                }
                                return Container();
                              }),
                              Divider(height: 16),
                              Consumer<HomeViewmodel>(
                                  builder: (context, value, _) {
                                switch (value.cityList.status) {
                                  case Status.loading:
                                    return const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          "Pilih provinsi asal terlebih dahulu."),
                                    );
                                  case Status.error:
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          value.cityList.message.toString()),
                                    );
                                  case Status.completed:
                                    return DropdownButton(
                                        isExpanded: true,
                                        value: selectedCity,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 30,
                                        elevation: 2,
                                        hint: const Text('Pilih Kota Asal'),
                                        style: const TextStyle(
                                            color: Colors.black),
                                        items: value.cityList.data!
                                            .map<DropdownMenuItem<City>>(
                                                (City value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child:
                                                Text(value.cityName.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCity = newValue;
                                            // homeViewmodel
                                            //     .getCityList(selectedCity.cityId);
                                          });
                                        });
                                  default:
                                }
                                return Container();
                              }),
                              Divider(height: 16),
                              Consumer<HomeViewmodel>(
                                  builder: (context, value, _) {
                                switch (value.provinceList.status) {
                                  case Status.loading:
                                    return Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    );
                                  case Status.error:
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Text(value.provinceList.message
                                          .toString()),
                                    );
                                  case Status.completed:
                                    return DropdownButton(
                                        isExpanded: true,
                                        value: selectedProvinceDest,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 30,
                                        elevation: 2,
                                        hint: Text('Pilih Provinsi Tujuan'),
                                        style: TextStyle(color: Colors.black),
                                        items: value.provinceList.data!
                                            .map<DropdownMenuItem<Province>>(
                                                (Province value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child:
                                                Text(value.province.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedProvinceDest = newValue;
                                            selectedCityDest = null;
                                            homeViewmodel.getCityListDest(
                                                selectedProvinceDest
                                                    .provinceId);
                                          });
                                        });
                                  default:
                                }
                                return Container();
                              }),
                              Divider(height: 16),
                              Consumer<HomeViewmodel>(
                                  builder: (context, value, _) {
                                switch (value.cityListDest.status) {
                                  case Status.loading:
                                    return const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          "Pilih provinsi tujuan terlebih dahulu."),
                                    );
                                  case Status.error:
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Text(value.cityListDest.message
                                          .toString()),
                                    );
                                  case Status.completed:
                                    return DropdownButton(
                                        isExpanded: true,
                                        value: selectedCityDest,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 30,
                                        elevation: 2,
                                        hint: const Text('Pilih Kota Tujuan'),
                                        style: const TextStyle(
                                            color: Colors.black),
                                        items: value.cityListDest.data!
                                            .map<DropdownMenuItem<City>>(
                                                (City value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child:
                                                Text(value.cityName.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCityDest = newValue;
                                            // homeViewmodel
                                            //     .getCityList(selectedCity.cityId);
                                          });
                                        });
                                  default:
                                }
                                return Container();
                              }),
                              Divider(height: 16),
                              TextField(
                                controller: _controller,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Berat Kiriman',
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    curWeight = newValue;
                                  });
                                },
                              ),
                              Divider(height: 16),
                              DropdownButton(
                                  isExpanded: true,
                                  value: selectedCourier,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  elevation: 2,
                                  hint: const Text('Pilih Kurir'),
                                  style: const TextStyle(color: Colors.black),
                                  items: ["jne", "tiki", "pos"]
                                      .map((courier) =>
                                          DropdownMenuItem<String>(
                                            value: courier,
                                            child: Text(courier.toUpperCase()),
                                          ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCourier = newValue;
                                    });
                                  }),
                              Divider(height: 16),
                              ElevatedButton(
                                  onPressed: (selectedProvince != null &&
                                          selectedProvinceDest != null &&
                                          selectedCity != null &&
                                          selectedCityDest != null &&
                                          curWeight != null &&
                                          selectedCourier != null)
                                      ? () {
                                          print(
                                              "selectedCity: ${selectedCity.cityId}");
                                          print(
                                              "selectedCityDest: ${selectedCityDest.cityId}");
                                          print("curWeight: $curWeight");
                                          print(
                                              "selectedCourier: $selectedCourier");
                                          homeViewmodel.getCostsList(
                                              selectedCity.cityId,
                                              selectedCityDest.cityId,
                                              int.parse(curWeight),
                                              selectedCourier);
                                        }
                                      : null,
                                  child: Text("Lihat Ongkos Kirim"),
                                  style: ButtonStyle())
                            ],
                          ),
                        ),
                      ),
                    )),
                Flexible(
                    flex: 2,
                    child: Container(
                        color: Colors.amber,
                        width: double.infinity,
                        height: double.infinity,
                        child: Consumer<HomeViewmodel>(
                            builder: (context, value, _) {
                          switch (value.costsList.status) {
                            case Status.loading:
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "Tombol Ongkos Kirim belum dapat ditekan"),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child: Text(value.costsList.message.toString()),
                              );
                            case Status.completed:
                              return ListView.builder(
                                  itemCount: value.costsList.data?.length,
                                  itemBuilder: (context, index) {
                                    return CardCosts(
                                        value.costsList.data!.elementAt(index));
                                  });
                            default:
                          }
                          return Container();
                        }))),
              ])),
        ));
  }
}
