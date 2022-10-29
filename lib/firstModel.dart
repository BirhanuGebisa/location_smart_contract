// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:location_smart_contract/secure.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:location_smart_contract/main.dart' as pass;

class FirstModel extends ChangeNotifier {
  bool isLoading = true;
  late Client _httpClient;
  late String _contractAddress;
  late String _abi;
  late Web3Client _client;
// ignore: unused_field
  late Credentials _credentials;
  late String x;
  late String y;
  late String latitude;
  late String longitude;
  late DeployedContract _contract;
  late ContractFunction _readCoordinates;
  Future<void> initiateSetup() async {
    _httpClient = Client();
    _client = Web3Client(
        "https://goerli.infura.io/v3/949471a93d714f98ad886c1083bf009e",
        _httpClient);
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    _abi = await rootBundle.loadString("../assets/Employe.json");
    _contractAddress = "0x4943030bce7e49dd13b4dd120c0fef7dde3c18a0";
//print(_abi);
//print(_contractAddress);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(
        "f34a1a59c2e4bf11b60acc7f77788e99b7b711f3285eaad4408fc7dfbe1341dc");
//print(_credentials);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abi, "Project"),
        EthereumAddress.fromHex(_contractAddress));
    _readCoordinates = _contract.function("readCoordinates");
    print(_contract);
//print("stopped here");
  }

  getCoordinates() async {
    initiateSetup();
    List readCoordinates = await _client
        .call(contract: _contract, function: _readCoordinates, params: []);
    x = readCoordinates[0];
    y = readCoordinates[1];
    print("data retrieved");
    print(x);
    print(y);
//print(pass.password);
    latitude = EncryptionDecryption.decryptAES(x);
    longitude = EncryptionDecryption.decryptAES(y);
    print("Decrypted");
    print(latitude);
    print(longitude);
    isLoading = false;
    notifyListeners();
  }

  void addCoordinates(String lat_1, String lon_1) {}
}
