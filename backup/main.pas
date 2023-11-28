unit main;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Winapi.Windows,
{$ELSE}
  Forms, Graphics, Controls, Dialogs, sysutils, Variants, Classes, Messages,
{$ENDIF}
  Client, StdCtrls,
  Services.Utils.Dtos;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    ClientInstance: PBClient;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$IFnDEF FPC}
  {$R *.dfm}                          r
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TForm1.Button1Click(Sender: TObject);
var
  result: string;
begin
  ClientInstance := PBClient.Create('http://pocketbase.io/');
  result         := ClientInstance
    .Collection('posts')
    .GetList();

  // ClientInstance

  // ClientInstance
  // .Collections('')
  // .GetList<CollectionModel>;
end;

end.
