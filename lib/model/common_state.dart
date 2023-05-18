


class CommonState{

  final String errText;
  final bool isError;
  final bool isSuccess;
  final bool isLoad;

  CommonState({
    required this.errText,
    required this.isError,
    required this.isLoad,
    required this.isSuccess
});
  

  CommonState copyWith({
    String? errText,
    bool? isError,
    bool? isSuccess,
    bool? isLoad
}){
    return CommonState(
        errText: errText ?? this.errText,
        isError: isError ?? this.isError,
        isLoad: isLoad ?? this.isLoad,
        isSuccess: isSuccess ?? this.isSuccess
    );
  }


}