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

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    ClientInstance: PBClient;
  public
    { Public declarations }
  end;


function FormatarJSON(const JSONString: string): string;

var
  Form1: TForm1;

implementation

{$IFnDEF FPC}
  {$R *.dfm}

{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TForm1.Button1Click(Sender: TObject);
var
  Result: string;
begin
  ClientInstance := PBClient.Create('https://pocketbase.io/');
  Result := ClientInstance
    .Collection('posts')
    //.StartPage(1)
    //.ResultsPerPage(10)
    //.SortBy('Name')
    .GetList();

  Memo1.Text := FormatarJSON(Result);

  // ClientInstance

  // ClientInstance
  // .Collections('')
  // .GetList<CollectionModel>;
end;


function FormatarJSON(const JSONString: string): string;
const
  IndentSize = 2;
var
  Indent: integer;
  Index: integer;
  InQuote: boolean;
  LastChar: char;
begin
  Result := '';
  Indent := 0;
  InQuote := False;

  for Index := 1 to Length(JSONString) do
  begin
    if InQuote then
    begin
      Result := Result + JSONString[Index];
      if (JSONString[Index] = '"') and (LastChar <> '\') then
        InQuote := False;
    end
    else
    begin
      case JSONString[Index] of
        '{', '[':
        begin
          Inc(Indent);
          Result := Result + JSONString[Index] + sLineBreak +
            StringOfChar(' ', Indent * IndentSize);
        end;
        '}', ']':
        begin
          Dec(Indent);
          Result := Result + sLineBreak + StringOfChar(' ', Indent * IndentSize) +
            JSONString[Index];
        end;
        ',':
        begin
          Result := Result + ',' + sLineBreak + StringOfChar(' ', Indent * IndentSize);
        end;
        ':':
        begin
          Result := Result + ': ';
        end;
        '"':
        begin
          Result := Result + '"';
          InQuote := True;
        end;
        else
          Result := Result + JSONString[Index];
      end;
    end;

    LastChar := JSONString[Index];
  end;
end;

end.
