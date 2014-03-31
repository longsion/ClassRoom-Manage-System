unit FormReg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, DB, ADODB;

type
  Treg = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    Edit6: TEdit;
    Button1: TButton;
    Label9: TLabel;
    Label10: TLabel;
    ADOCommand1: TADOCommand;
    ADOQuery1: TADOQuery;
    ComboBox2: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  reg: Treg;

implementation
  uses FormLogin;

{$R *.dfm}

procedure Treg.Button1Click(Sender: TObject);
begin
  if (edit1.Text='') or (edit2.text='') then
  begin                                     //----��ʾ��������ѧ��/�̹��� ������
    if combobox1.Text='ѧ��' then
      showmessage('����������ѧ�ź�����')
    else
      showmessage('����������̹��ź�����');
  end
  else if label10.Visible=true then
       showmessage('������������벻һ��')
  else
  begin
    if combobox1.Text='ѧ��' then
    begin
      adocommand1.CommandText:='insert into student values('''+edit1.Text+''','''+edit2.Text+''','''+edit5.Text+''','''+edit6.text+''','''+edit3.Text+''')' ;
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from student where ѧ��='''+edit1.text+'''');
    end
    else
    begin
      adocommand1.CommandText:='insert into teacher values('''+edit1.Text+''','''+edit2.Text+''','''+edit5.Text+''','''+edit6.text+''','''+combobox2.text+''','''+edit3.Text+''')';
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where �̹���='''+edit1.text+'''');
    end;
    adoquery1.open;
    if adoquery1.FieldByName('����').AsString<>'' then        //�����ѧ��/�̹��� �ѱ�ע�� ��ʾ��ʾ��Ϣ
      showmessage('���û����ѱ�ע��')
    else
    begin
      adocommand1.Execute;
      showmessage('ע��ɹ�');
      Reg.Close;
    end;
  end;

end;

procedure Treg.ComboBox1Change(Sender: TObject);
begin
  if combobox1.Text='��ʦ' then         //���ѡ�е��ǽ�ʦ����������Ӧ��LABEL��EDIT��COMBOBOX
  begin
    label3.Caption:='�̹���:';
    label7.Caption:='�绰:';
    label8.Caption:='����:';
    label9.Visible:=true;
    label9.Caption:='�ȼ�:';
    combobox2.Visible:=true;
    edit1.Clear;
    edit2.Clear;
    edit3.Clear;
    edit4.Clear;
    edit5.Clear;
    edit6.Clear;
  end
  else                              //���ѡ�е���ѧ������������Ӧ��LABEL��EDIT��COMBOBOX
  begin
    label3.Caption:='ѧ��:';
    label7.caption:='�༶:';
    label8.caption:='ѧԺ:';
    label9.Visible:=false;
    combobox2.Visible:=false;
    edit1.Clear;
    edit2.Clear;
    edit3.Clear;
    edit4.Clear;
    edit5.Clear;
    edit6.Clear;
  end;

end;

procedure Treg.Edit3Change(Sender: TObject);  //----���������������벻һ�£�����ʾ��ʾ
begin
  if edit3.Text<>edit4.Text then
    label10.Visible:=true
  else
    label10.Visible:=false;
end;

procedure Treg.Edit4Change(Sender: TObject);  //----���������������벻һ�£�����ʾ��ʾ
begin
  if edit4.Text<>edit3.text then
    label10.Visible:=true
  else
    label10.Visible:=false;
end;

procedure Treg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Login.Show;  //��ʾ��¼����
end;

procedure Treg.FormShow(Sender: TObject);
begin
  Login.Hide; //���ص�½����
  combobox1.Text:='ѧ��';
  combobox2.Visible:=false;
end;

end.
