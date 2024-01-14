

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taskl/provides/counter.dart';

List<SingleChildWidget> providers = [
 
              ChangeNotifierProvider(
                create: (context) => CounterProvider(),
              ),
             
             
];
