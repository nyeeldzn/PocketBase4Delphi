unit Model.Store.BaseAuthStore;

interface

uses
  SysUtils,
  {$IFnDef FPC}
  System.JSON,
  REST.JSON,
  {$ELSE}
  fpjson, jsonparser,
  {$ENDIF}
  Generics.Collections,
  Model.Stores.Utils.Jwt,
  Model.Stores.Utils.Cookie;

const
  DEFAULT_COOCKIE_KEY = 'pb_auth';

type

  Tuple = record
    key: string;
    value: string;
  end;

  AuthModel = Tuple;

  TProc = procedure() of object;
  OnStoreChangeFunction = procedure(AToken: string; AModel: AuthModel) of object;

  BaseAuthStore = class abstract
  protected
    FBaseToken: string;
    FBaseModel: AuthModel;
  private
    FOnChangeCallbacks: TList<OnStoreChangeFunction>;
    procedure triggerChange();
    function onChange(ACallback: OnStoreChangeFunction; AFireImmediately: boolean = False): TProc;
  public
    property Token: string read FBaseToken;
    property Model: AuthModel read FBaseModel;

    function IsValid(): boolean;
    function IsAdmin(): boolean;
    function IsAuthRecord(): boolean;

    // procedure LoadFromCookie(Cookie: string; Key: string = DEFAULT_COOCKIE_KEY);
    // function ExportToCookie(options: SerializeOptions ; const Key: string = defaultCookieKey): string;

    procedure Save(AToken: string; AModel: AuthModel);
    procedure Clear();
  end;

implementation

{ BaseAuthStore }

function BaseAuthStore.IsAdmin: boolean;
begin
 // Result := TJWTUtils.getTokenPayload(self.Token).GetValue('type').ToString = 'admin';
end;

function BaseAuthStore.IsAuthRecord: boolean;
begin
//  Result := TJWTUtils.getTokenPayload(self.Token).GetValue('type').ToString = 'authRecord';
end;

function BaseAuthStore.IsValid: boolean;
begin
 // Result := not TJWTUtils.IsTokenExpired(self.Token)
end;
//
// procedure BaseAuthStore.LoadFromCookie(Cookie, Key: string);
// var
// jsonObject: TJSONObject;
// rawData   : string;
// data      : TJSONObject;
// Token     : string;
// Model     : TJSONValue;
// begin
// jsonObject := TJSONObject.Create;
// data       := TJSONObject.Create;
//
// try
// jsonObject := TJSONObject.ParseJSONValue(Cookie) as TJSONObject;
// if Assigned(jsonObject) then
// begin
// rawData := jsonObject.GetValue(Key).Value;
//
// try
// data := TJSONObject.ParseJSONValue(rawData) as TJSONObject;
// except
// on E: EJSONException do
// begin
// Exit;
// end;
// end;
//
// // Normalização
// if
// not Assigned(data) or
// not(data is TJSONObject)
// then
// begin
// data.Free;
// data := TJSONObject.Create;
// end;
//
// // Obter os valores token e model
// Token := data.GetValue('token').Value;
// // Model := data.GetValue('model');
//
// // Chamada para função Save
// Save(Token, AuthModel.Create('', ''));
// end;
// finally
// jsonObject.Free;
// data.Free;
// end;
//
// end;
//
// function BaseAuthStore.ExportToCookie(options: SerializeOptions = nil; const Key: string = defaultCookieKey): string;
// var
// DefaultOptions: SerializeOptions;
// Payload       : TJSONObject;
// rawData       : TJSONObject;
// ResultData    : string;
// ResultLength  : Integer;
// Prop          : string;
// ExtraProps    : TArray<string>;
// begin
// // Definição das opções padrão para serialização do cookie
// DefaultOptions          := SerializeOptions.Create;
// DefaultOptions.Secure   := True;
// DefaultOptions.SameSite := True;
// DefaultOptions.HttpOnly := True;
// DefaultOptions.Path     := '/';
//
// // Extração da data de expiração do token, se existir
// Payload := getTokenPayload(self.Token);
// if Assigned(Payload) and (Payload.GetValue('exp') <> nil) then
// DefaultOptions.Expires := EncodeDate(1970, 1, 1) + (Payload.GetValue('exp').AsInt64 * OneSecond)
// else
// DefaultOptions.Expires := EncodeDate(1970, 1, 1);
//
// // Fusão das opções padrão com as opções do usuário, se existirem
// if Assigned(options) then
// MergeSerializeOptions(DefaultOptions, options);
//
// // Criação do objeto JSON com os dados a serem serializados
// rawData := TJSONObject.Create;
// try
// rawData.AddPair('token', self.Token);
//
// // Verificação e serialização do modelo, se existir
// if Assigned(self.Model) then
// begin
// // Simplificação do modelo para um conjunto mínimo de propriedades
// rawData.AddPair('model', self.Model.Simplify);
//
// // Adição de propriedades adicionais específicas
// ExtraProps := TArray<string>.Create('collectionId', 'username', 'verified');
// for Prop in self.Model.Properties do
// if ExtraProps.Contains(Prop) then
// rawData.GetValue('model').AsType<TJSONObject>.AddPair(Prop, self.Model.GetValue(Prop));
// end
// else
// rawData.AddPair('model', TJSONNull.Create);
//
// // Serialização do objeto JSON em string
// ResultData := TJSONUtils.ToJSON(rawData);
//
// // Verificação do tamanho da string serializada para tomada de decisão
// ResultLength := Length(ResultData);
// if ResultLength > 4096 then
// begin
// // Redução do modelo para tamanho menor, se exceder um limite
// // ... (lógica de redução)
// ResultData := TJSONUtils.ToJSON(rawData); // Serialização final com modelo reduzido
// end;
//
// // Resultado final da serialização
// Result := CookieSerialize(Key, ResultData, DefaultOptions);
//
// finally
// rawData.Free;
// end;
// end;

function BaseAuthStore.onChange(ACallback: OnStoreChangeFunction;
  AFireImmediately: boolean): TProc;
begin
  FOnChangeCallbacks.Add(ACallback);

  if
    AFireImmediately
  then
    ACallback(self.Token, self.Model);

//  Result := procedure
//    begin
//      FOnChangeCallbacks.Remove(ACallback);
//    end;
end;

procedure BaseAuthStore.triggerChange;
var
  callback :OnStoreChangeFunction;
begin
  if
    Assigned(FOnChangeCallbacks)
  then
  begin
    for callback in FOnChangeCallbacks do
    begin
      callback(self.Token, self.Model)
    end;
  end;
end;

procedure BaseAuthStore.Save(AToken: string; AModel: AuthModel);
begin
  FBaseToken := AToken;
  FBaseModel := AModel;

  triggerChange();
end;

procedure BaseAuthStore.Clear;
begin
  FBaseToken := '';
  FBaseModel := nil;

  triggerChange();
end;

end.
