import 'package:cbt_tpa_fic17_app/data/datasources/auth_remote_datasource.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/product_local_datasource.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/product_remote_data_source.dart';
import 'package:cbt_tpa_fic17_app/presentation/home/bloc/order/order_bloc.dart';
import 'package:cbt_tpa_fic17_app/presentation/home/bloc/qris/qris_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/colors.dart';
import 'data/datasources/midtrans_remote_datasource.dart';
import 'data/models/response/product_response_model.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/logout/logout_bloc.dart';
import 'presentation/auth/splash_page.dart';
import 'presentation/home/bloc/checkout/checkout_bloc.dart';
import 'presentation/home/bloc/checkout/models/order_item.dart';
import 'presentation/home/bloc/checkout/models/order_model.dart';
import 'presentation/home/bloc/history/history_bloc.dart';
import 'presentation/home/bloc/product/product_bloc.dart';
import 'presentation/home/bloc/qris_status/qris_status_bloc.dart';
import 'presentation/home/pages/payment_success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final order = OrderModel(
      paymentMethod: "Gopay",
      nominalPayment: 100000,
      orders: [OrderItem(product: Product(), quantity: 5)],
      totalQuantity: 10,
      totalPrice: 100000,
      cashierId: 0,
      cashierName: "Azka",
      isSync: false,
      transactionTime: DateTime.now().toIso8601String());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
              ProductRemoteDataSource(), ProductLocalDataSource.instance)
            ..add(const ProductEvent.syncProduct()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(ProductLocalDataSource.instance),
        ),
        BlocProvider(
          create: (context) => QrisBloc(MidtrasRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => QrisStatusBloc(MidtrasRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tiket Wisata',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dialogTheme: const DialogTheme(elevation: 0),
          textTheme: GoogleFonts.outfitTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.outfit(
              color: AppColors.primary,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
          ),
        ),
        // home: const SplashPage(),
        home: PaymentSuccessPage(
          data: order,
        ),
      ),
    );
  }
}
