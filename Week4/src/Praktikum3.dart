void main() {
  var gifts = {
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };

  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };

  print(gifts);
  print(nobleGases);

  var mhs1 = Map<String, String>();
  var mhs2 = Map<int, String>();

  // Update gifts
  gifts['Nama'] = 'Damar Galih';
  gifts['NIM'] = '2341720200';

  // Update nobleGases
  nobleGases[99] = 'Damar Galih';
  nobleGases[100] = '2341720200';

  // Update mhs1
  mhs1['Nama'] = 'Damar Galih';
  mhs1['NIM'] = '2341720200';

  // Update mhs2
  mhs2[1] = 'Damar Galih';
  mhs2[2] = '2341720200';

  print("\nAfter update:");
  print("gifts: $gifts");
  print("nobleGases: $nobleGases");
  print("mhs1: $mhs1");
  print("mhs2: $mhs2");
}
