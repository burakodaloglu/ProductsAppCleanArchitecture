import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app_clean_architecture/features/products/presentation/bloc/products/remote/remote_products_event.dart';
import 'package:products_app_clean_architecture/features/products/presentation/bloc/products/remote/remote_products_state.dart';


import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/get_products_use_case.dart';

class RemoteProductsBloc extends Bloc<RemoteProductsEvent, RemoteProductsState> {
  final GetProductsUseCase _getProductsUseCase;

  RemoteProductsBloc(this._getProductsUseCase) : super(const RemoteProductsLoading()) {
    on<GetProducts>(onGetProducts);
  }

  void onGetProducts(GetProducts event, Emitter<RemoteProductsState> emit) async {
    final dataState = await _getProductsUseCase();

    if (dataState is Success && dataState.data!.isNotEmpty) {
      emit(RemoteProductsDone(dataState.data!));
    }
    if (dataState is Error) {
      debugPrint('DataState Error: ${dataState.error!.message}');
      emit(RemoteProductsError(dataState.error!));
    }
  }
}
