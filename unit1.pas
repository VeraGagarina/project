unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql55conn, sqldb, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, DBGrids, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    MySQL55Connection1: TMySQL55Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure MySQL55Connection1AfterConnect(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
   try
   MySQL55Connection1.Connected:=true;
 except
   ShowMessage('Подключение к БД: ОШИБКА!');
   exit;
 end;
   try
   SQLTransaction1.Active:=true;
 except
   ShowMessage('Транзакция: ОШИБКА!');
   exit;
 end;
end;

procedure TForm1.MySQL55Connection1AfterConnect(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var
    str_sql : string;
begin
  try
   SQLQuery1.Active := false;
   SQLQuery1.SQL.Clear;
   str_sql := 'SET character_set_client='+#39+'utf8'+#39+',character_set_connection='+#39+'cp1251'+#39+',character_set_results='+#39+'utf8'+#39+';';
   SQLQuery1.sql.add(str_sql);
   SQLQuery1.ExecSQL;
   SQLQuery1.SQL.Clear;
   SQLQuery1.sql.add('SELECT * FROM sport;');
   SQLQuery1.Open;
  except
   ShowMessage('SQL-запрос: ОШИБКА!');
   exit;
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var a:string;
begin
   try
  SQLQuery1.Active:=false;
  SQLQuery1.ExecSQL;
  SQLQuery1.SQL.Clear;
  a:='SELECT *FROM sport WHERE sport = "'+ComboBox1.Text+'"';
 // Label2.Caption:= a;
  SQLQuery1.SQL.Add(a);
  SQLQuery1.Open;
  except
    SQLQuery1.Close;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var a:string;
begin
  try

  SQLQuery1.Active:=false;
  SQLQuery1.ExecSQL;
  SQLQuery1.SQL.Clear;
  a:='SELECT * FROM sport';
  //Label2.Caption:=a;
  SQLQuery1.SQL.Add(a);
  SQLQuery1.Open;
  except
    SQLQuery1.Close;
  end;
  ComboBox1.Text:= '';
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;

end.

