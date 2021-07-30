unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.UI.Intf, FireDAC.Stan.Async,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.VCLUI.Script,
  FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.Comp.Script, Vcl.StdCtrls,
  Vcl.ExtCtrls, Unit2;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Memo1: TMemo;
    Panel4: TPanel;
    Panel5: TPanel;
    Memo2: TMemo;
    Button1: TButton;
    FDScript1: TFDScript;
    FDGUIxScriptDialog1: TFDGUIxScriptDialog;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FDScript1ConsolePut(AEngine: TFDScript; const AMessage: string;
      AKind: TFDScriptOutputKind);
    procedure Button2Click(Sender: TObject);
  private
    procedure Reset;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Reset;
  FDScript1.Connection.Connected := False;
  // Coleção de SQLScrips
  with FDScript1.SQLScripts do begin
    Clear;
    // O Script Raiz tem que estar com o indice zero
    with add do begin
      Name := 'Root';
      SQL.Add('@Scripts');
    end;
    with add do begin
      Name := 'Scripts';
      SQL := Memo1.Lines;
    end;
  end;
  FDScript1.ValidateAll;
  ShowMessage(FDScript1.ExecuteAll.ToString);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Reset;
  if OpenDialog1.Execute then
    FDScript1.SQLScriptFileName := OpenDialog1.FileName;

  FDScript1.ValidateAll;
  FDScript1.ExecuteAll;
end;

procedure TForm1.FDScript1ConsolePut(AEngine: TFDScript; const AMessage: string;
  AKind: TFDScriptOutputKind);
begin
  if AEngine.CurrentCommand <> nil then
    memo2.Lines.AddObject(AMessage, TObject(AEngine.CurrentCommand.Position.Y))
  else
    memo2.Lines.AddObject(AMessage, TObject(-1));
  Application.ProcessMessages;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DataModule2.FDConnection1.GetInfoReport(Memo2.Lines);
  FDScript1.ScriptOptions.BreakOnError := True;
  FDGUIxScriptDialog1.Options := FDGUIxScriptDialog1.Options - [ssAutoHide];
end;

procedure TForm1.Reset;
begin
  FDScript1.SQLScripts.Clear;
  FDScript1.SQLScriptFileName := '';
  FDScript1.ScriptOptions.Reset;
end;

end.
