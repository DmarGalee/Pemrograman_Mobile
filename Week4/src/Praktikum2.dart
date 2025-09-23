void main() {
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
  print(halogens);

  var names1 = <String>{};
  Set<String> names2 = {};
  var names3 = {};

  names1.add("Damar Galih"); 
  names1.add("2341720200");

  names2.addAll({"Damar Galih", "2341720200"});

  print("names1: $names1");
  print("names2: $names2");
  print("names3 (Map): $names3");
}
