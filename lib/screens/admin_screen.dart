import 'dart:convert';
import 'package:courts_ecommerce/models/product.dart';
import 'package:courts_ecommerce/providers/product_provider.dart';
import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:courts_ecommerce/screens/edit_product_screen.dart';
import 'package:courts_ecommerce/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminScreen extends StatefulWidget {

  const AdminScreen({Key? key}) : super(key: key);

  @override
  _adminScreenState createState() => _adminScreenState();

}

class _adminScreenState extends State<AdminScreen> {

  bool _isMonthlySelected = true;
  late Future<List<Product>> _productListFuture;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    _productListFuture = _productService.fetchData();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user!;

    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome,',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black, // Use theme color
                            ),
                          ),
                          Text(
                            '${user.fullName}',
                            // 'admin',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black, // Use theme color
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0,20, 20, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/adminProfile');
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5,
                          shape: const CircleBorder(),
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Container(
                              width: 55,
                              height: 55,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://t4.ftcdn.net/jpg/05/09/59/75/360_F_509597532_RKUuYsERhODmkxkZd82pSHnFtDAtgbzJ.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.73,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Color(0xFF808080),
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                            unselectedLabelStyle: TextStyle(),
                            indicatorColor: Colors.black,
                            tabs: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.chair,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  Tab(
                                    text: 'Furniture',
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.analytics,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  Tab(
                                    text: 'Analyze',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Management Furniture',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.black, // Use theme color
                                                ),
                                              ),
                                              Text(
                                                'Edit or Delete Products',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: Colors.black, // Use theme color
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context, '/addProduct');
                                            },
                                            borderRadius: BorderRadius.circular(10),
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: Container(
                                              width: 31,
                                              height: 31,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.lightGreenAccent, width: 2),
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.black,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: FutureBuilder <List<Product>> (
                                        future: _productListFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<Product> productList = snapshot.data!;
                                            return
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: productList?.length,
                                                itemBuilder: (context, index) {
                                                  Product product = productList[index];
                                                  return Dismissible(
                                                    key: UniqueKey(),
                                                    direction: DismissDirection.endToStart,
                                                    onDismissed: (direction) async  {
                                                      final result = await showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text("Note !"),
                                                            content: Text("Are you sure you want to delete this product ?"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(false);
                                                                },
                                                                child: Text("Cancel"),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  await Provider.of<ProductProvider>(context, listen: false).deleteProduct('${product.productID}',);
                                                                  Navigator.of(context).pop(true);
                                                                },
                                                                child: Text("Delete"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      if (result == false) {
                                                        setState(() {});
                                                        return;
                                                      }
                                                      setState(() {
                                                        productList.removeAt(index);
                                                      });
                                                    },
                                                    background: Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(0),
                                                      ),
                                                      color: Color(0xFFFF0206),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(15),
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => EditProductScreen(productID: product.productID)),
                                                        );
                                                      },
                                                      child: Card(
                                                        clipBehavior: Clip.none,
                                                        color: Colors.white,
                                                        elevation: 4,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors.white,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                  EdgeInsets.all(5),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.circular(8),
                                                                    child:
                                                                    Image.memory(
                                                                      base64Decode('${product.productImgVideo}'),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        '${product.productName}',
                                                                        style: TextStyle(
                                                                          fontFamily: 'Plus Jakarta Sans',
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 12,
                                                                          color: Colors.black, // Use theme color
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        'RM ${product.productPrice.toStringAsFixed(2)}',
                                                                        style: TextStyle(
                                                                          fontFamily: 'Plus Jakarta Sans',
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 10,
                                                                          color: Colors.black, // Use theme color
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 100,
                                                                width: 5,
                                                                child: VerticalDivider(
                                                                  thickness: 15,
                                                                  color:
                                                                  Color(0xFFFF0206),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return CircularProgressIndicator();
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context).width,
                                            height: MediaQuery.sizeOf(context).height * 0.5,
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                            ),
                                            child: _isMonthlySelected
                                                ? MonthlySalesChart() // 如果选择月度分析，则显示月度销售图表
                                                : YearlySalesChart(), // 如果选择年度分析，则显示年度销售图表
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.sizeOf(context).width,
                                            height: MediaQuery.sizeOf(context).height,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isMonthlySelected = true;
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    elevation: 4,
                                                    side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Monthly',
                                                        style: TextStyle(
                                                          fontFamily: 'Plus Jakarta Sans',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isMonthlySelected = false;
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    elevation: 4,
                                                    side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 36),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Yearly',
                                                        style: TextStyle(
                                                          fontFamily: 'Plus Jakarta Sans',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MonthlySalesChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 月度销售数据
    var monthlyData = [
      SalesData('Jan', 200),
      SalesData('Feb', 300),
      SalesData('Mar', 400),
      // 添加其它月份数据...
    ];

    return SalesChart(data: monthlyData);
  }
}

class YearlySalesChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 年度销售数据
    var yearlyData = [
      SalesData('2021', 5000),
      SalesData('2022', 6000),
      SalesData('2023', 7000),
      // 添加其它年份数据...
    ];

    return SalesChart(data: yearlyData);
  }
}

class SalesChart extends StatelessWidget {
  final List<SalesData> data;

  SalesChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: BarChart(
              data: data,
            ),
          ),
          Text(
            data.first.month, // 如果是月度销售数据，显示月份；如果是年度销售数据，显示年份
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  final List<SalesData> data;

  BarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data.map((item) {
                  return Row(
                    children: [
                      Text(item.month, style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Container(
                        width: item.amount.toDouble(), // 根据销售数量确定柱状图宽度
                        height: 30,
                        color: Colors.blue,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('销售数量', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class SalesData {
  final String month;
  final int amount;

  SalesData(this.month, this.amount);
}














