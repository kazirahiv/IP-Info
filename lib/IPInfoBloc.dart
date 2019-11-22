import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ip_info/IPInfoModel.dart';
import 'IPInfoRepo.dart';


class IPInfoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchIPInfoEvent extends IPInfoEvent
{
  final _ipinfo;
  FetchIPInfoEvent(this._ipinfo);
  @override
  // TODO: implement props
  List<Object> get props => [_ipinfo];
}


class ResetIPInfo extends IPInfoEvent{

}


class FetchIPInfoState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class IPInfoIsNotSearched extends FetchIPInfoState{

}

class IPInfoIsLoading extends FetchIPInfoState{

}

class IPInfoIsNotLoaded extends FetchIPInfoState{

}

class IPInfoIsLoaded extends FetchIPInfoState{
  final _ipinfo;

  IPInfoIsLoaded(this._ipinfo);

  IPInfoModel get getIPInfo => _ipinfo;

  @override
  // TODO: implement props
  List<Object> get props => [_ipinfo];
}


class IPInfoBloc extends Bloc<IPInfoEvent, FetchIPInfoState>
{
  IPInfoRepo ipInfoRepo;

  IPInfoBloc(this.ipInfoRepo);

  @override
  FetchIPInfoState get initialState => IPInfoIsNotSearched();

  @override
  Stream<FetchIPInfoState> mapEventToState(IPInfoEvent event) async*{
    
    if(event is FetchIPInfoEvent)
    {
      yield IPInfoIsLoading();
      try{
        IPInfoModel infoModel = await ipInfoRepo.getIPInfo(event._ipinfo);
        yield IPInfoIsLoaded(infoModel);
      }catch(_){
        yield IPInfoIsNotLoaded();
      }
    }else if(event is ResetIPInfo){
      yield IPInfoIsNotSearched();
    }
  }


}