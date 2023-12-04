program DEMO;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

uses
  Forms,
  {$IFDEF FPC}
  opensslsockets,
  {$ENDIF }
  main in '..\..\main.pas' {Form1},
  Client in '..\..\Client.pas',
  ClientResponseError in '..\ClientResponseError.pas',
  Model.Store.BaseAuthStore in 'Model.Store.BaseAuthStore.pas',
  Model.Stores.Utils.Jwt in 'utils\Model.Stores.Utils.Jwt.pas',
  Model.Stores.Utils.Cookie in 'utils\Model.Stores.Utils.Cookie.pas',
  Services.Utils.Options in '..\..\services\utils\Services.Utils.Options.pas',
  Services.Utils.BaseService in '..\..\services\utils\Services.Utils.BaseService.pas',
  Services.SettingsService in '..\..\services\Services.SettingsService.pas',
  Services.Utils.Dtos in '..\..\services\utils\Services.Utils.Dtos.pas',
  Services.CollectionServices in '..\..\services\Services.CollectionServices.pas',
  Services.Utils.CrudServices in '..\..\services\utils\Services.Utils.CrudServices.pas',
  Model.Stores.LocalAuthStore in 'Model.Stores.LocalAuthStore.pas',
  Services.RecordService in '..\..\services\Services.RecordService.pas',
  Demo.Post in '..\..\Demo.Post.pas',
  Utils.RTTI in '..\..\utils\Utils.RTTI.pas',
  Services.RealtimeService in '..\..\services\Services.RealtimeService.pas',
  Services.Utils.ServerSentEvents in '..\..\services\utils\Services.Utils.ServerSentEvents.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
