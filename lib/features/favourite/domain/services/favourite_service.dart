import 'package:get/get.dart';
import 'package:sixam_mart/common/models/response_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/favourite/domain/repositories/favourite_repository_interface.dart';
import 'package:sixam_mart/features/favourite/domain/services/favourite_service_interface.dart';
import 'package:sixam_mart/helper/address_helper.dart';

class FavouriteService implements FavouriteServiceInterface {
  final FavouriteRepositoryInterface favouriteRepositoryInterface;
  FavouriteService({required this.favouriteRepositoryInterface});

  @override
  Future<Response> getFavouriteList() async {
    return await favouriteRepositoryInterface.getList();
  }

  @override
  Future<ResponseModel> addFavouriteList(int? id, bool isStore) async {
    return await favouriteRepositoryInterface.add(null, isStore: isStore, id: id);
  }

  @override
  Future<ResponseModel> removeFavouriteList(int? id, bool isStore) async {
    return await favouriteRepositoryInterface.delete(id, isStore: isStore);
  }

  @override
  List<Item?> wishItemList(Item item) {
    List<Item?> wishItemList = [];
    final zoneData = AddressHelper.getUserAddressFromSharedPref()?.zoneData;
    if (zoneData == null) {
      return wishItemList;
    }
    for (var zone in zoneData) {
      for (var module in zone.modules ?? const []) {
        if(module.id == item.moduleId){
          if(module.pivot?.zoneId == item.zoneId){
            wishItemList.add(item);
          }
        }
      }
    }
    return wishItemList;
  }

  @override
  List<int?> wishItemIdList (Item item) {
    List<int?> wishItemIdList = [];
    final zoneData = AddressHelper.getUserAddressFromSharedPref()?.zoneData;
    if (zoneData == null) {
      return wishItemIdList;
    }
    for (var zone in zoneData) {
      for (var module in zone.modules ?? const []) {
        if(module.id == item.moduleId){
          if(module.pivot?.zoneId == item.zoneId){
            wishItemIdList.add(item.id);
          }
        }
      }
    }
    return wishItemIdList;
  }

  @override
  List<Store?> wishStoreList(dynamic store) {
    List<Store?> wishStoreList = [];
    final zoneData = AddressHelper.getUserAddressFromSharedPref()?.zoneData;
    if (zoneData == null) {
      return wishStoreList;
    }
    final Store parsedStore = Store.fromJson(store);
    for (var zone in zoneData) {
      for (var module in zone.modules ?? const []) {
        if(module.id == parsedStore.moduleId){
          if(module.pivot?.zoneId == parsedStore.zoneId){
            wishStoreList.add(parsedStore);
          }
        }
      }
    }
    return wishStoreList;
  }

  @override
  List<int?> wishStoreIdList(dynamic store) {
    List<int?> wishStoreIdList = [];
    final zoneData = AddressHelper.getUserAddressFromSharedPref()?.zoneData;
    if (zoneData == null) {
      return wishStoreIdList;
    }
    final Store parsedStore = Store.fromJson(store);
    for (var zone in zoneData) {
      for (var module in zone.modules ?? const []) {
        if(module.id == parsedStore.moduleId){
          if(module.pivot?.zoneId == parsedStore.zoneId){
            wishStoreIdList.add(parsedStore.id);
          }
        }
      }
    }
    return wishStoreIdList;
  }

}