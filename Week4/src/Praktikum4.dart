void main() {
  // var list1 = <int?>[1, 2, 3];
  // var list2 = [0, ...list1];  
  // print(list1);               
  // print(list2);              
  // print(list2.length);

  // list1 = [1, 2, null]; 
  // print(list1);

  // var list3 = [0, ...list1];
  // print(list3.length);

  // // Tambahan list NIM
  // var listNIM = [1, 2341720200, 3, 4, 5, 6, 7, 8, 9];  
  // var gabungan = [...list2, ...listNIM];  
  // print(listNIM);
  // print(gabungan);
  // print(gabungan.length);

// Gunakan promoActive
  // var promoActive = true;
  // var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  // print(nav);

  // promoActive = false;
  // var nav2 = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  // print(nav2);

  // var login = 'Manager';

  // var nav2 = [
  //   'Home',
  //   'Furniture',
  //   'Plants',
  //   if (login == 'Manager') 'Inventory'
  // ];
  // print(nav2);

  // // Coba kondisi lain
  // login = 'Admin';
  // var nav3 = [
  //   'Home',
  //   'Furniture',
  //   'Plants',
  //   if (login == 'Manager') 'Inventory'
  // ];
  // print(nav3);

  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
  print(listOfStrings);
}
