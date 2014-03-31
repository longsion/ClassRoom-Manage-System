unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, DB, ADODB;

type
  TLogin = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation
  uses FormReg, FormStudent, FormTeacher, FormManager;

{$R *.dfm}

procedure TLogin.Button1Click(Sender: TObject);     //----��ʾע�ᴰ��-----
begin
  reg.show;
end;

procedure TLogin.Button2Click(Sender: TObject);
begin
  if checkbox1.Checked=true then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from student where ѧ��='''+edit1.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('ѧ��').AsString='' then           //---��ʾѧ�Ų�����---
      showmessage('�����ڸ�ѧ��')
    else
    begin
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from student where (ѧ��='''+edit1.text+''')'+'and(����='''+edit2.text+''')');
      adoquery1.Open;
      if adoquery1.FieldByName('ѧ��').AsString='' then      //---���ѧ�Ŵ��ڣ�������� ��ʾ�����������---
        showmessage('�����������')
      else                               //----��ѧ������----
      begin
        studentview.Show;
        adoquery1.Close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select ���� from student where ѧ��='''+edit1.text+'''');
        adoquery1.Open;     //----��ѧ��������Statusbar�������ʾ ������ѧ��---
        studentview.StatusBar1.Panels[1].Text:=adoquery1.FieldByName('����').AsString;
        studentview.StatusBar1.Panels[2].Text:=edit1.text;
        Login.Hide;
      end;
    end;
  end;

  if checkbox2.Checked=true then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from teacher where �̹���='''+edit1.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('�̹���').AsString='' then         //---��ʾ�̹��Ų�����---
      showmessage('�����ڸý̹���')
    else
    begin
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where (�̹���='''+edit1.text+''')'+'and(����='''+edit2.text+''')');
      adoquery1.Open;
      if adoquery1.FieldByName('�̹���').AsString='' then    //---����̹��Ŵ��ڣ�������� ��ʾ�����������--
        showmessage('�����������')
      else
      begin                               //----�򿪽�ʦ����----
        teacherview.Show;
        adoquery1.Close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select ���� from teacher where �̹���='''+edit1.text+'''');
        adoquery1.Open;     //----���ʦ������Statusbar�������ʾ �����ͽ̹���---
        teacherview.StatusBar1.Panels[1].Text:=adoquery1.FieldByName('����').AsString;
        teacherview.StatusBar1.Panels[2].Text:=edit1.text;
        Login.Hide;
      end;
    end;
  end;

  if checkbox3.Checked=true then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from manager where ����Ա��='''+edit1.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('����Ա��').AsString='' then   //----��ʾ����Ա�Ų�����----
      showmessage('�����ڸù���Ա��')
    else
    begin
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from manager where (����Ա��='''+edit1.text+''')'+'and(����='''+edit2.text+''')');
      adoquery1.Open;
      if adoquery1.FieldByName('����Ա��').AsString='' then    //---�������Ա�Ŵ��ڣ����������������ʾ�����������--
        showmessage('�����������')
      else
      begin                //----�򿪹���Ա����----
        managerview.Show;
        adoquery1.Close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select ���� from manager where ����Ա��='''+edit1.text+'''');
        adoquery1.Open;     //----�����Ա������Statusbar�������ʾ �����͹���Ա��---
        managerview.StatusBar1.Panels[1].Text:=adoquery1.FieldByName('����').AsString;
        managerview.StatusBar1.Panels[2].Text:=edit1.text;
        Login.Hide;
      end;
    end;
  end;
end;

procedure TLogin.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked=true then        //���ѡ�У�������������Ϊδѡ��
  begin
    CheckBox2.Checked:=false;
    CheckBox3.Checked:=false;
    label2.caption:='ѧ��:';
  end;
  if (CheckBox1.checked=false) and(CheckBox2.checked=false)and(CheckBox3.checked=false) then
  begin                  //���3����δѡ�У���Ĭ��checkbox1��ѡ��
    CheckBox1.Checked:=true;
    label2.Caption:='ѧ��:';
  end;
end;

procedure TLogin.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked=true then          //���ѡ�У�������������Ϊδѡ��
  begin
    CheckBox1.Checked:=false;
    CheckBox3.Checked:=false;
    label2.caption:='�̹���:';
  end;
  if (CheckBox1.checked=false) and(CheckBox2.checked=false)and(CheckBox3.checked=false) then
  begin                          //���3����δѡ�У���Ĭ��checkbox1��ѡ��
    CheckBox1.Checked:=true;
    label2.Caption:='ѧ��:';
  end;

end;


procedure TLogin.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked=true then          //���ѡ�У�������������Ϊδѡ��
  begin
    CheckBox1.Checked:=false;
    CheckBox2.Checked:=false;
    label2.caption:='����Ա��:';
  end;
  if (CheckBox1.checked=false) and(CheckBox2.checked=false)and(CheckBox3.checked=false) then
  begin                          //���3����δѡ�У���Ĭ��checkbox1��ѡ��
    CheckBox1.Checked:=true;
    label2.Caption:='ѧ��:';
  end;
end;

end.
