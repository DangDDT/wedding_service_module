import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_wedding_service_param.dart';
import 'package:wss_repository/wss_repository.dart';

abstract class IWeddingServiceService {
  Future<ServiceCategoryModel> getCategory(String id);
  Future<WeddingServiceModel> getDetail(String id);
  Future<WeddingServiceModel> registerService(WeddingServiceModel service);
  Future<List<WeddingServiceModel>> getServices(GetWeddingServiceParam param);
  Future<bool> updateService(WeddingServiceModel service);
  Future<bool> reActiveService(String id);
  Future<bool> suspendService(String id, String reason);
  Future<List<TransactionModel>> getTransactions(
    GetPartnerPaymentHistoryParam param,
  );
}
