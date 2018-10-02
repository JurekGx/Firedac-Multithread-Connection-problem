unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  System.SyncObjs;

type
  TDBThread = class(TThread)
    Baza, SQL: string;
    Memo: TMemo;
    Numer: integer;
  protected
    procedure Execute; override;
    constructor Create(const aBaza, aSQL: string; aMemo: TMemo;
      aNumer: integer); overload;

  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    pnlGrid1: TPanel;
    mmGrid5: TMemo;
    Panel3: TPanel;
    mmGrid4: TMemo;
    Splitter5: TSplitter;
    Panel4: TPanel;
    mmGrid3: TMemo;
    Splitter7: TSplitter;
    Panel5: TPanel;
    mmGrid2: TMemo;
    Splitter9: TSplitter;
    Panel6: TPanel;
    mmGrid1: TMemo;
    Splitter11: TSplitter;
    Button1: TButton;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label11: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    t1, t2, t3, t4, t5: TDBThread;
    function CreateGetConnDef(const AServerName, aDBName: string): string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  csFlaga: TCriticalSection;

implementation

uses FireDAC.DApt;

{$R *.dfm}
{ TDBThread }

constructor TDBThread.Create(const aBaza, aSQL: string; aMemo: TMemo;
  aNumer: integer);
begin
  inherited Create(false);
  Baza := aBaza;
  SQL := aSQL;
  Memo := aMemo;
  Numer := aNumer;
end;

procedure TDBThread.Execute;

  procedure WriteMessage(const Tresc: string);
  begin
    Synchronize(
      procedure
      begin
        Memo.Lines.Add(Tresc);
      end);
  end;

var
  oConn: TFDConnection;
  oPrc: TFDQuery;
  s: string;
  i: integer;
  oParams: TStrings;
begin
  FreeOnTerminate := false;

        csFlaga.Acquire;
  oConn := TFDConnection.Create(nil);
  oConn.ConnectionDefName := Baza;
        csFlaga.Release;

  WriteMessage('connecting to '#13 + oConn.Params.Database);
  oPrc := TFDQuery.Create(nil);
  oPrc.Connection := oConn;
  oParams := nil;
  try
    try

      oConn.Connected := True;
    except
      on E: Exception do
      begin
        WriteMessage('connection error: ' + E.Message);
        exit;
      end;

    end;

    WriteMessage('connected');

    WriteMessage('selecting...');

    try
      oPrc.Open(SQL);
    except
      on E: Exception do
      begin
        WriteMessage('selection error: ' + E.Message);
        exit;
      end;
    end;

    oPrc.First;
    while not oPrc.Eof do
    begin
      s := '';
      for i := 0 to oPrc.FieldCount - 1 do
        s := s + oPrc.Fields[i].AsString + ';';
      WriteMessage(IntToStr(oPrc.RecNo) + ': ' + s);
      oPrc.Next;
    end;
  finally
    if Assigned(oParams) then
      oParams.Free;
    oPrc.Free;
    oConn.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  s1, s2, s3: string;
begin
  if not FDManager.Active then
    FDManager.Active := True;

  csFlaga := TCriticalSection.Create;

  s1 := CreateGetConnDef(Edit1.Text, Edit2.Text);
  s2 := CreateGetConnDef(Edit3.Text, Edit4.Text);
  s3 := CreateGetConnDef(Edit5.Text, Edit6.Text);

  t1 := TDBThread.Create(s1, 'select * from rdb$database', mmGrid1, 1);
  t2 := TDBThread.Create(s2, 'select first 10 * from rdb$relations',  mmGrid2, 2);
  t3 := TDBThread.Create(s3, 'select * from rdb$database', mmGrid3, 3);
  t4 := TDBThread.Create(s1, 'select first 10 * from rdb$fields', mmGrid4, 4);
  t5 := TDBThread.Create(s2, 'select first 10 * from rdb$collations', mmGrid5, 5);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  t1.WaitFor;
  t1.Free;

  t2.WaitFor;
  t2.Free;

  t3.WaitFor;
  t3.Free;

  t4.WaitFor;
  t4.Free;

  t5.WaitFor;
  t5.Free;
  csFlaga.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  mmGrid1.Clear;
  mmGrid2.Clear;
  mmGrid3.Clear;
  mmGrid4.Clear;
  mmGrid5.Clear;

end;

function TForm1.CreateGetConnDef(const AServerName, aDBName: string): string;
var
  slParams: TStrings;
  i: integer;
begin
  result := '';
  for i := 0 to FDManager.ConnectionDefs.Count - 1 do
    if FDManager.ConnectionDefs[i].Params.Database = aDBName then
    begin
      result := FDManager.ConnectionDefs[i].Name;
      break;
    end;

  if result = '' then
  begin
    slParams := TStringList.Create;
    try
      result := 'Baza_' + IntToStr(random(100000));
      slParams.Add('Database=' + aDBName);
      slParams.Add('Protocol=TCPIP');
      slParams.Add('Server=' + AServerName);
      slParams.Add('User_Name=SYSDBA');
      slParams.Add('Password=qaz123');
//      slParams.Add('ConnectTimeout=5');
//      slParams.Add('LoginTimeout=5');
      slParams.Add('CharacterSet=UTF8');
      slParams.Add('Pooled=true');
      FDManager.AddConnectionDef(result, 'FB', slParams);
//      with FDManager.ConnectionDefs.FindConnectionDef(Result) do
//      begin
//        Params.PoolCleanupTimeout := 4;
//        Params.PoolExpireTimeout := 4;
//      end;

    finally
      slParams.Free;
    end;
  end;

end;

end.
