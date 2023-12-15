import 'package:wedding_service_module/src/domain/enums/private/transaction_status.dart';
import 'package:wedding_service_module/src/domain/mappers/base/base_data_mapper_profile.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';
import 'package:wss_repository/base/constants/default_value_mapper_constants.dart';
import 'package:wss_repository/entities/partner_payment_history.dart';

class TransactionMapper
    extends BaseDataMapperProfile<PartnerPaymentHistory, TransactionModel> {
  @override
  TransactionModel mapData(PartnerPaymentHistory entity, Mapper mapper) {
    return TransactionModel(
      id: entity.id.toString(),
      title: 'Thanh toán đơn hàng ${entity.order?.code}',
      amount: entity.total?.toDouble() ?? DefaultValueConstants.defaultDouble,
      createdAt: entity.createDate ?? DefaultValueConstants.dateTime,
      status: TransactionStatusX.fromCode(entity.status),
      description: entity.order?.code,
      paidAt: entity.createDate ?? DefaultValueConstants.dateTime,
      detailInfos: entity.order?.orderDetails
              .map(
                (e) => TransactionDetailInfo(
                  serviceName: e.service?.name ?? DefaultValueConstants.string,
                  address: e.address ?? DefaultValueConstants.string,
                  price: e.price?.toDouble() ??
                      DefaultValueConstants.defaultDouble,
                ),
              )
              .toList() ??
          [],
    );
  }
}
